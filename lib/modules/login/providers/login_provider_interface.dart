import '../../../core/auth/models/auth_model.dart';
import '../models/login_config_model.dart';
import '../models/login_form_model.dart';

abstract class LoginProviderInterface {
  Future<LoginConfigModel> getConfig();
  Future<AuthSessionModel> login(LoginFormModel data);
  Future<void> setDeviceToken(String deviceToken);
  Future<String?> getDeviceToken();
  Future<bool> isUserExist(String username);
}
