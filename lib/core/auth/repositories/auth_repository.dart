import '../../../../constant/error_codes.dart';
import '../../../../core/auth/models/auth_model.dart';
import '../../../../core/auth/models/user_model.dart';
import '../../../../core/auth/providers/auth_local_provider_interface.dart';
import '../../../../core/auth/providers/auth_provider_interface.dart';
import '../../../../core/auth/repositories/auth_repository_interface.dart';
import '../../../../utils/services/local_storage_service/local_storage_service.dart';
import 'package:injectable/injectable.dart';
import 'package:moor/moor.dart';

/// Authorization Class to Process User Session
@Singleton(as: AuthRepositoryInterface)
class AuthRepository implements AuthRepositoryInterface {
  final AuthLocalProviderInterface _authLocalProvider;
  final AuthProviderInterface _authProvider;
  AuthRepository(this._authLocalProvider, this._authProvider);

  @override
  Future<List<AuthSessionModel>> getAllSessions() async {
    final sessionList = await _authLocalProvider.getAllSession();
    return sessionList
        .map((e) => AuthSessionModel(
            uid: e.userId,
            xRefreshToken: e.refreshToken,
            xToken: e.token,
            expiresIn: e.tokenExpiration,
            isLoggedIn: e.active,
            deviceToken: e.deviceToken))
        .toList();
  }

  @override
  Future<AuthSessionModel?> getLoggedinSession() async {
    final d = await _authLocalProvider.getActiveSession();
    if (d != null) {
      return AuthSessionModel(
          uid: d.userId,
          xRefreshToken: d.refreshToken,
          xToken: d.token,
          expiresIn: d.tokenExpiration,
          isLoggedIn: d.active,
          deviceToken: d.deviceToken);
    } else {
      return null;
    }
  }

  @override
  Future<void> loginSession(AuthSessionModel data) async {
    // check if session is exist
    final session = await _authLocalProvider.getSessionById(data.uid);

    //TODO: untuk support multiuser, harus tambah satu tabel lagi untuk set selected user
    //Clean active session
    final allSession = await _authLocalProvider.getAllSession();
    for (final item in allSession) {
      await _authLocalProvider.updateSession(SessionsCompanion(
          userId: Value(item.userId),
          token: Value(item.token),
          tokenExpiration: Value(item.tokenExpiration),
          refreshToken: Value(item.refreshToken),
          deviceToken: Value(item.deviceToken),
          updatedDate: Value(DateTime.now()),
          active: const Value(false)));
    }

    if (session == null) {
      await _authLocalProvider.insertSession(SessionsCompanion(
          tokenExpiration: Value(data.expiresIn),
          userId: Value(data.uid),
          token: Value(data.xToken),
          deviceToken: Value(data.deviceToken!),
          refreshToken: Value(data.xRefreshToken)));
    } else {
      await _authLocalProvider.updateSession(SessionsCompanion(
          userId: Value(data.uid),
          token: Value(data.xToken),
          tokenExpiration: Value(data.expiresIn),
          refreshToken: Value(data.xRefreshToken),
          deviceToken: Value(data.deviceToken!),
          updatedDate: Value(DateTime.now()),
          active: const Value(true)));
    }
  }

  @override
  Future<void> logoutSession() async {
    final session = await _authLocalProvider.getActiveSession();
    if (session != null) {
      await _authProvider.logout();
      await _authLocalProvider.updateSession(session.copyWith(active: false));
    }
  }

  @override
  Future<void> removeSession(AuthSessionModel data) async {
    final session = await _authLocalProvider.getActiveSession();
    if (session != null) {
      await _authLocalProvider.deleteSession(session);
    }
  }

  @override
  Future<AuthSessionModel> getNewToken() async {
    final session = await getLoggedinSession();
    if (session != null) {
      return _authProvider.getNewToken(session.xRefreshToken);
    }
    throw FrontendErrors.sessionInvalid;
  }

  @override
  Future<AuthUserModel> getUserData() async {
    final sessionData = await getLoggedinSession();
    return _authProvider.getUserData(sessionData!.uid);
  }

  @override
  Future<bool> isLoggedIn() async {
    final d = await _authLocalProvider.getActiveSession();
    return d != null;
  }

  @override
  Future<void> removeAllSession() {
    return _authLocalProvider.truncateSession();
  }
}
