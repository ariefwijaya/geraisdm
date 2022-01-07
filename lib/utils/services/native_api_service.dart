import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import '../../../../constant/error_codes.dart';
import '../../../../core/app_setting.dart';
import '../../../../core/settings/models/environment_model.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

import 'local_storage_service/local_storage_service.dart';
import 'remote_config_service/remote_config_default.dart';

/// Class that have static functions to access native platform or thirdparty
@module
abstract class NativeApiService {
  /// Return Current App Package and platform info
  @preResolve
  @lazySingleton
  Future<EnvironmentModel> getPlatformInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    if (UniversalPlatform.isAndroid) {
      return EnvironmentModel(
          appBuildNumber: packageInfo.buildNumber,
          appVersion: packageInfo.version,
          packageName: packageInfo.packageName,
          osType: EnvOsType.android,
          appVersionOld: packageInfo.version,
          osTypeOld: EnvOsType.android);
    } else if (UniversalPlatform.isIOS) {
      return EnvironmentModel(
          appBuildNumber: packageInfo.buildNumber,
          appVersion: packageInfo.version,
          packageName: packageInfo.packageName,
          osType: EnvOsType.ios,
          appVersionOld: packageInfo.version,
          osTypeOld: EnvOsType.ios);
    } else if (UniversalPlatform.isWeb) {
      return EnvironmentModel(
          appBuildNumber: packageInfo.buildNumber,
          appVersion: packageInfo.version,
          packageName: packageInfo.packageName,
          osType: EnvOsType.web,
          appVersionOld: packageInfo.version,
          osTypeOld: EnvOsType.web);
    } else {
      throw FrontendErrors.unknownPlatform;
    }
  }

  @lazySingleton
  AppDatabase databaseInstance() {
    return constructDb(logStatements: AppSetting.showLog);
  }

  @singleton
  FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin =>
      FlutterLocalNotificationsPlugin();

  @singleton
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;

  @singleton
  FirebaseDynamicLinks get firebaseDynamicLinks =>
      FirebaseDynamicLinks.instance;

  @singleton
  FirebaseCrashlytics get firebaseCrashlytics => FirebaseCrashlytics.instance;

  @preResolve
  @lazySingleton
  Future<RemoteConfig> get remoteConfig async {
    final remoteConfig = RemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 15),
      minimumFetchInterval: const Duration(hours: 12),
    ));

    await remoteConfig.setDefaults(remoteConfigDefaultValue);

    await remoteConfig.ensureInitialized();
    return remoteConfig;
  }

  @preResolve
  @lazySingleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
