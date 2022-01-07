import '../../../../core/auth/models/user_model.dart';

abstract class AuthProviderInterface {
  Future<AuthUserModel> getUserData();

  Future<void> logout();
}
