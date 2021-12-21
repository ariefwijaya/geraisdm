import '../../../../core/auth/models/auth_model.dart';
import '../../../../core/auth/models/user_model.dart';

abstract class AuthRepositoryInterface {
  /// Get all available session in local storage.
  /// It used to get sessions when there is no logged in users
  Future<List<AuthSessionModel>> getAllSessions();

  /// Get current logged in users
  Future<AuthSessionModel?> getLoggedinSession();

  /// return if user logged IN
  Future<bool> isLoggedIn();

  /// Save user session if login is successful
  Future<void> loginSession(AuthSessionModel data);

  /// Logout user but don't remove session data. Only set the status to not active.
  Future<void> logoutSession();

  /// Clear user All session data and log out
  Future<void> removeAllSession();

  /// Clear user session data and log out
  Future<void> removeSession(AuthSessionModel data);

  /// Refresh and request new token using refresh token
  Future<AuthSessionModel> getNewToken();

  /// Get user profile and data
  Future<AuthUserModel> getUserData();
}
