import 'package:geraisdm/core/auth/models/auth_model.dart';
import 'package:geraisdm/modules/login/models/login_config_model.dart';
import 'package:geraisdm/modules/login/models/login_form_model.dart';

abstract class LoginRepositoryInterface {
  Future<LoginConfigModel> getConfig();
  Future<AuthSessionModel> login(LoginFormModel data);
  Future<bool> isUserExist(String username);
  Future<void> setDeviceToken(String deviceToken);
}
