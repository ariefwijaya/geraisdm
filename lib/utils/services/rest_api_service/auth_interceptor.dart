import '../../../../config/injectable/injectable_core.dart';
import '../../../../core/auth/repositories/auth_repository_interface.dart';
import '../../../../core/settings/models/environment_model.dart';
import '../../../../core/settings/repositories/app_repository_interface.dart';
import 'package:dio/dio.dart';
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

      // update token and repeat
      // Lock to block the incoming request until the token updated
      _lockDio();
      handler.reject(err);
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
}
