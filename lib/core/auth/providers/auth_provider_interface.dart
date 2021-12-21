import '../../../../core/auth/models/auth_model.dart';
import '../../../../core/auth/models/user_model.dart';

abstract class AuthProviderInterface {
  Future<AuthSessionModel> getNewToken(String refreshToken);

  Future<AuthUserModel> getUserData(int userId);

  Future<void> logout();
}
