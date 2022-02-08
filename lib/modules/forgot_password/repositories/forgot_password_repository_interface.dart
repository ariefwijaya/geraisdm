import 'package:geraisdm/modules/forgot_password/models/forgot_password_form_model.dart';
import 'package:geraisdm/modules/forgot_password/models/forgot_password_model.dart';

abstract class ForgotPasswordRepositoryInterface {
  Future<ForgotPasswordModel> requestResetPassword(String username);
  Future<void> confirmReset(ForgotPasswordFormModel form);
}
