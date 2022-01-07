import '../../../../core/auth/models/auth_model.dart';
import '../../../../core/auth/models/user_model.dart';
import '../../../../core/auth/providers/auth_local_provider_interface.dart';
import '../../../../core/auth/providers/auth_provider_interface.dart';
import '../../../../core/auth/repositories/auth_repository_interface.dart';
import '../../../../utils/services/local_storage_service/local_storage_service.dart';
import 'package:injectable/injectable.dart';
import 'package:drift/drift.dart';

/// Authorization Class to Process User Session
@Singleton(as: AuthRepositoryInterface)
class AuthRepository implements AuthRepositoryInterface {
  final AuthLocalProviderInterface _authLocalProvider;
  final AuthProviderInterface _authProvider;
  AuthRepository(this._authLocalProvider, this._authProvider);

  @override
  Future<AuthSessionModel?> getLoggedinSession() async {
    final d = await _authLocalProvider.getActiveSession();
    if (d != null) {
      return AuthSessionModel(
          uid: d.userId,
          xToken: d.token,
          isLoggedIn: d.active,
          deviceToken: d.deviceToken);
    } else {
      return null;
    }
  }

  @override
  Future<void> loginSession(AuthSessionModel data) async {
    await _authLocalProvider.clearSession();
    await _authLocalProvider.insertSession(SessionsCompanion(
        userId: Value(data.uid),
        token: Value(data.xToken),
        deviceToken: Value(data.deviceToken!)));
  }

  @override
  Future<void> logoutSession() async {
    await _authLocalProvider.clearSession();
    await _authProvider.logout();
  }

  @override
  Future<void> removeSession(AuthSessionModel data) async {
    final session = await _authLocalProvider.getActiveSession();
    if (session != null) {
      await _authLocalProvider.deleteSession(session);
    }
  }

  @override
  Future<AuthUserModel> getUserData() async {
    return _authProvider.getUserData();
  }

  @override
  Future<bool> isLoggedIn() async {
    final d = await _authLocalProvider.getActiveSession();
    return d != null;
  }
}
