import 'package:geraisdm/modules/forgot_password/models/forgot_password_form_model.dart';
import 'package:geraisdm/modules/forgot_password/models/forgot_password_model.dart';
import 'package:geraisdm/modules/forgot_password/providers/forgot_password_provider_interface.dart';
import 'package:geraisdm/modules/forgot_password/repositories/forgot_password_repository_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgotPasswordRepositoryInterface)
class ForgotPasswordRepository implements ForgotPasswordRepositoryInterface {
  final ForgotPasswordProviderInterface forgotPasswordProviderInterface;

  const ForgotPasswordRepository(
      {required this.forgotPasswordProviderInterface});

  @override
  Future<void> confirmReset(ForgotPasswordFormModel form) {
    return forgotPasswordProviderInterface.confirmReset(form);
  }

  @override
  Future<ForgotPasswordModel> requestResetPassword(String username) {
    return forgotPasswordProviderInterface.requestResetPassword(username);
  }
}
