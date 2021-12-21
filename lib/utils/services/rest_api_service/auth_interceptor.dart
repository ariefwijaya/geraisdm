import '../../../../config/injectable/injectable_core.dart';
import '../../../../config/routes/routes.gr.dart';
import '../../../../constant/api_path.dart';
import '../../../../constant/error_codes.dart';
import '../../../../constant/localizations.g.dart';
import '../../../../core/auth/models/auth_model.dart';
import '../../../../core/auth/repositories/auth_repository_interface.dart';
import '../../../../core/settings/models/environment_model.dart';
import '../../../../core/settings/repositories/app_repository_interface.dart';
import '../../../../utils/services/rest_api_service/rest_api_interface.dart';
import '../../../../utils/services/rest_api_service/rest_api_service.dart';
import '../../../../widgets/alert_component.dart';
import '../../../../widgets/button_component.dart';
import '../../../../widgets/icon_alert_component.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

/// This interceptor is simplified because is doesn't contemplate
/// a refresh token, which you should take care of.
/// Custom Interceptor to handle Authorizations and Platform Info.
///
/// Access token obtained via API after user logged in and saved into
/// some local storage
///
@injectable
class AuthInterceptor extends QueuedInterceptorsWrapper {
  final Dio loggedDio;
  final AppRepositoryInterface appRepository;
  final AuthRepositoryInterface authRepository;

  AuthInterceptor(
      {required this.loggedDio,
      required this.appRepository,
      required this.authRepository});

  bool isDialogReloginShown = false;

  String _tokenize(String? token) {
    return "Bearer $token";
  }

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final session = await authRepository.getLoggedinSession();
    final lang = await appRepository.getSelectedLanguage();
    final envInfo = getIt.get<EnvironmentModel>();

    final Map<String, String?> additionalHeaders = <String, String?>{
      'Authorization': _tokenize(session?.xToken),
      'lang': lang.languageCode
    }..addAll(envInfo.toJson().cast<String, String?>());

    if (session?.deviceToken != null) {
      additionalHeaders['device-token'] = session?.deviceToken;
    }
    //will pass any override value
    final Map<String, String?> overrideHeaders =
        options.headers.cast<String, String?>();
    additionalHeaders.addAll(overrideHeaders);

    options.headers.addAll(additionalHeaders);

    return handler.next(options);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final RequestOptions options = err.response!.requestOptions;
      final currentSession = await authRepository.getLoggedinSession();

      // If the token has been updated, repeat directly.
      if (currentSession?.xToken != null &&
          options.headers['Authorization'] !=
              _tokenize(currentSession!.xToken)) {
        options.headers['Authorization'] = _tokenize(currentSession.xToken);
        // repeat
        try {
          final r = await Dio(loggedDio.options).fetch(options);
          handler.resolve(r);
        } catch (e) {
          handler.reject(e as DioError);
        }
        return;
      }

      if (currentSession == null) {
        return handler.next(err);
      }

      final BaseOptions loggedOptions = loggedDio.options;
      // update token and repeat
      // Lock to block the incoming request until the token updated
      _lockDio();
      try {
        final d =
            await _getNewToken(loggedOptions, currentSession.xRefreshToken);
        options.headers['Authorization'] = _tokenize(d.xToken);
        final r = await Dio(loggedOptions).fetch(options);
        handler.resolve(r);
      } catch (e) {
        if (e == BackendErrors.refreshTokenInvalid) {
          _showAlertSessionInvalid();
        }
        handler.reject(err);
      }
      // _clearDio();
      _unlockDio();
      return;
    } else {
      return handler.next(err);
    }
  }

  void _lockDio() {
    loggedDio.lock();
  }

  void _unlockDio() {
    loggedDio.unlock();
  }

  Future<AuthSessionModel> _getNewToken(
      BaseOptions options, String refreshToken) async {
    final currentSession = await authRepository.getLoggedinSession();
    final RestApiInterface restRefresh = RestApiService(dio: Dio(options));
    final response =
        await restRefresh.get(ApiPath.session, body: {"token": refreshToken});
    final jsonmap = <String, dynamic>{};
    response.headers.forEach((name, values) {
      jsonmap[name] = values[0];
    });

    final responseData = response.data as Map<String, dynamic>;
    //unnecessary for refresh session
    jsonmap['uid'] = currentSession!.uid;
    jsonmap['expires_in'] = responseData['expires_in'] != null
        ? int.tryParse(responseData['expires_in'] as String)
        : null;

    final refreshModel = AuthSessionModel.fromJson(jsonmap);
    final authModel = currentSession.copyWith(
        xToken: refreshModel.xToken,
        xRefreshToken: refreshModel.xRefreshToken,
        expiresIn: refreshModel.expiresIn);
    await authRepository.loginSession(authModel);
    return authModel;
  }

  Future _showAlertSessionInvalid() {
    final context = getContext();
    if (context == null || isDialogReloginShown) {
      return Future.value();
    }

    isDialogReloginShown = true;

    return showAlertPlaceholder(
        context: context,
        icon: const ErrorIconPlaceholder(),
        title: LocaleKeys.authorization_refresh_token_invalid_title.tr(),
        subtitle: LocaleKeys.authorization_refresh_token_invalid_subtitle.tr(),
        action: FilledButton.large(
            buttonText:
                LocaleKeys.authorization_refresh_token_invalid_relogin.tr(),
            onPressed: () =>
                context.router.replaceAll([const LoginRoute()]))).then(
        (value) => isDialogReloginShown = false);
  }

  BuildContext? getContext() {
    return getIt.get<AppRouter>().navigatorKey.currentContext;
  }
}

// class MyTokenStorage implements TokenStorage<OAuth2Token> {
//   final AuthRepositoryInterface authRepository;
//   const MyTokenStorage(this.authRepository);
//   @override
//   Future<void> delete() async {
//     final currentSession = await authRepository.getLoggedinSession();
//     if (currentSession != null) {
//       await authRepository.logoutSession();
//     }
//   }

//   @override
//   Future<OAuth2Token?> read() async {
//     final session = await authRepository.getLoggedinSession();
//     if (session != null) {
//       return OAuth2Token(
//           accessToken: session.xToken,
//           refreshToken: session.xToken,
//           expiresIn: session.expiresIn);
//     } else {
//       return null;
//     }
//   }

//   @override
//   Future<void> write(OAuth2Token token) async {
//     final session = await authRepository.getLoggedinSession();
//     if (session != null) {
//       await authRepository.loginSession(session.copyWith(
//           xToken: token.accessToken,
//           xRefreshToken: token.refreshToken,
//           expiresIn: token.expiresIn));
//     }
//   }
// }
