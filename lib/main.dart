import 'package:alice/alice.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_application/secure_application.dart';

import 'config/injectable/injectable_core.dart';
import 'config/routes/routes.gr.dart';
import 'core/auth/blocs/auth_bloc.dart';
import 'core/deeplink/blocs/deeplink_bloc/deeplink_bloc.dart';
import 'core/notification/blocs/notification_bloc.dart';
import 'core/settings/blocs/language_cubit/language_cubit.dart';
import 'core/settings/blocs/theme_cubit/theme_cubit.dart';
import 'env/env.dart';
import 'main.extend.dart';

Future<void> main() async {
  await setupConfiguration();

  await BlocOverrides.runZoned(
    () async {
      await setupReporter(const MyApp());
    },
    blocObserver: setupBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = getIt.get<AppRouter>();
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => getIt.get<AuthBloc>()),
        BlocProvider<ThemeCubit>(create: (context) => getIt.get<ThemeCubit>()),
        BlocProvider<LanguageCubit>(
            create: (context) => getIt.get<LanguageCubit>()..init()),
        BlocProvider<NotificationBloc>(
            create: (context) => getIt.get<NotificationBloc>()),
        BlocProvider<DeeplinkBloc>(
            create: (context) => getIt.get<DeeplinkBloc>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) => BlocListener<LanguageCubit, LanguageState>(
            listener: (context, langState) {
              context.setLocale(langState.languageCode.toLocale());
            },
            child: MaterialApp.router(
              routerDelegate: router.delegate(
                  initialDeepLink: const SplashRoute().path,
                  navigatorObservers: () => [
                        FirebaseAnalyticsObserver(
                            analytics: FirebaseAnalytics.instance),
                      ]),
              routeInformationParser:
                  router.defaultRouteParser(includePrefixMatches: true),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: state.themeData,
              title: Env.appName,
              builder: (context, child) {
                getIt.get<Alice>().setNavigatorKey(router.navigatorKey);
                return MultiBlocListener(
                    listeners: [
                      BlocListener<AuthBloc, AuthState>(
                          listener: (context, state) {
                        if (state is AuthAuthenticated) {
                          router.replaceAll([const HomeLayoutRoute()]);
                        } else if (state is AuthUnauthenticated) {
                          router.replaceAll([LoginRoute()]);
                        }
                      }),
                    ],
                    child: SecureApplication(
                      nativeRemoveDelay: 800,
                      onNeedUnlock: (secure) {
                        // print(
                        //     'need unlock maybe use biometric to confirm and then use sercure.unlock()');
                      },
                      child: currentEnv != "prod"
                          ? Banner(
                              message: currentEnv.toUpperCase(),
                              location: BannerLocation.topStart,
                              child: child)
                          : child!,
                    ));
              },
            )),
      ),
    );
  }
}
