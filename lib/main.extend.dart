import 'dart:ffi';

import 'package:alice/alice.dart';
import 'package:catcher/catcher.dart';
import 'package:catcher/model/platform_type.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/open.dart';

import 'config/injectable/injectable_core.dart';
import 'constant/app_constant.dart';
import 'core/app_setting.dart';
import 'core/auth/repositories/auth_repository_interface.dart';
import 'env/env.dart';
import 'utils/services/rest_api_service/rest_api_client.dart';

///Setup All Services configuration for the first time
Future setupConfiguration() async {
  //required to ensure flutter has been initialized first
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Hive.initFlutter();
  await EasyLocalization.ensureInitialized();
  //initial firebase
  await Firebase.initializeApp();

  //configure dependency injection
  await configureDependencies();
  setupAlice();
  await setupRestApiClient();
  setupSqlCipher();
}

/// call this method before using moor
void setupSqlCipher() {
  open.overrideFor(
      OperatingSystem.android, () => DynamicLibrary.open('libsqlcipher.so'));
}

Future<void> setupRestApiClient() {
  final RestApiClient restApiClient = RestApiClient();
  return restApiClient.addRequiredInterceptor();
}

void setupAlice() {
  final Alice alice = Alice(showNotification: currentEnv != "prod");
  getIt.registerLazySingleton<Alice>(() => alice);
}

//init hydrated bloc using hive
Future<Storage> setupHydratedBloc() async {
  return await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
}

Future<void> setupReporter(Widget child) async {
  final CatcherOptions debugOptions =
      CatcherOptions(SilentReportMode(), [ConsoleHandler()]);
  final CatcherOptions releaseOptions = CatcherOptions(
      SilentReportMode(),
      [
        CrashlyticsHandler(),
      ],
      reportOccurrenceTimeout: 10000);

  // runApp
  HydratedBlocOverrides.runZoned(
    () {
      Catcher(
          rootWidget: _setupLocalization(child),
          navigatorKey: GlobalKey<NavigatorState>(),
          debugConfig: debugOptions,
          releaseConfig: releaseOptions);
    },
    storage: await setupHydratedBloc(),
  );
}

Widget _setupLocalization(Widget child) {
  return EasyLocalization(
      supportedLocales: AppSetting.supportedLanguageList
          .map<Locale>((e) => e.toLocale())
          .toList(),
      path: AppConstant.localizationDir,
      assetLoader: SmartNetworkAssetLoader(
          assetsPath: AppConstant.localizationDir,
          localeUrl: (String localeName) => Env.localizationUrl),
      startLocale: AppSetting.defaultLanguage.toLocale(),
      fallbackLocale: AppSetting.defaultLanguage.toLocale(),
      useOnlyLangCode: true,
      //already override by hydrated cubit
      // saveLocale: false,
      child: child);
}

BlocObserver? setupBlocObserver() {
  if (kDebugMode && AppSetting.showLog) {
    return SimpleBlocObserver();
  } else if (kReleaseMode) {
    return ErrorBlocObserver();
  } else {
    return null;
  }
}

//To catch any unknown error in bloc
class ErrorBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    final stateValue = '${change.nextState}'.toLowerCase();

    if (stateValue.contains("failed") || stateValue.contains("failure")) {
      try {
        final errorState = change.nextState.props as List<Object>;
        if (errorState.isNotEmpty) {
          Catcher.reportCheckedError(errorState.first, errorState.last);
        }
      } catch (e, s) {
        Catcher.reportCheckedError(e, s);
      }
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    Catcher.reportCheckedError(error, stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // ignore: avoid_print
    print('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // ignore: avoid_print
    print('${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // ignore: avoid_print
    print('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}

class CrashlyticsHandler extends ReportHandler {
  final bool enableDeviceParameters;
  final bool enableApplicationParameters;
  final bool enableCustomParameters;
  final bool printLogs = AppSetting.showLog;

  final crashlyticInstance = getIt.get<FirebaseCrashlytics>();
  final authRepository = getIt.get<AuthRepositoryInterface>();

  CrashlyticsHandler(
      {this.enableDeviceParameters = true,
      this.enableApplicationParameters = true,
      this.enableCustomParameters = true});

  @override
  List<PlatformType> getSupportedPlatforms() {
    return [PlatformType.android, PlatformType.iOS, PlatformType.web];
  }

  @override
  Future<bool> handle(Report error, BuildContext? context) async {
    try {
      _printLog("Sending crashlytics report");

      final loggedInUser = await authRepository.getLoggedinSession();
      if (loggedInUser != null) {
        // set user ID to crashlytics if user already logged in
        await crashlyticInstance.setUserIdentifier(loggedInUser.uid.toString());
      }

      await crashlyticInstance.setCrashlyticsCollectionEnabled(true);
      crashlyticInstance.log(_getLogMessage(error));
      if (error.errorDetails != null) {
        await crashlyticInstance.recordFlutterError(error.errorDetails!);
      } else {
        await crashlyticInstance.recordError(
            error.error, error.stackTrace as StackTrace?);
      }
      _printLog("Crashlytics report sent");
      return true;
    } catch (exception) {
      _printLog("Failed to send crashlytics report: $exception");
      return false;
    }
  }

  String _getLogMessage(Report report) {
    final buffer = StringBuffer();
    if (enableDeviceParameters) {
      buffer.write("||| Device parameters ||| ");
      for (final entry in report.deviceParameters.entries) {
        buffer.write("${entry.key}: ${entry.value} ");
      }
    }
    if (enableApplicationParameters) {
      buffer.write("||| Application parameters ||| ");
      for (final entry in report.applicationParameters.entries) {
        buffer.write("${entry.key}: ${entry.value} ");
      }
    }
    if (enableCustomParameters) {
      buffer.write("||| Custom parameters ||| ");
      for (final entry in report.customParameters.entries) {
        buffer.write("${entry.key}: ${entry.value} ");
      }
    }
    return buffer.toString();
  }

  void _printLog(String log) {
    if (printLogs) {
      logger.info(log);
    }
  }
}
