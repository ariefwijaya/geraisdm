import '../../../../core/auth/models/auth_model.dart';
import '../../../../core/auth/models/user_model.dart';

abstract class AuthRepositoryInterface {
  /// Get current logged in users
  Future<AuthSessionModel?> getLoggedinSession();

  /// return if user logged IN
  Future<bool> isLoggedIn();

  /// Save user session if login is successful
  Future<void> loginSession(AuthSessionModel data);

  /// Logout user but don't remove session data. Only set the status to not active.
  Future<void> logoutSession();

  /// Clear user session data and log out
  Future<void> removeSession(AuthSessionModel data);

  /// Get user profile and data
  Future<AuthUserModel> getUserData();
}
