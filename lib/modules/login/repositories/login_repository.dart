import 'package:geraisdm/modules/login/models/login_config_model.dart';

import '../models/login_form_model.dart';
import '../../../core/auth/models/auth_model.dart';
import '../providers/login_provider_interface.dart';
import 'login_repository_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRepositoryInterface)
class LoginRepository implements LoginRepositoryInterface {
  final LoginProviderInterface loginProvider;
  const LoginRepository({required this.loginProvider});
  @override
  Future<bool> isUserExist(String username) {
    return loginProvider.isUserExist(username);
  }

  @override
  Future<AuthSessionModel> login(LoginFormModel data) async {
    final res = await loginProvider.login(data);
    final deviceToken = await loginProvider.getDeviceToken();
    return res.copyWith(deviceToken: deviceToken);
  }

  @override
  Future<void> setDeviceToken(String deviceToken) {
    return loginProvider.setDeviceToken(deviceToken);
  }

  @override
  Future<LoginConfigModel> getConfig() {
    return loginProvider.getConfig();
  }
}
