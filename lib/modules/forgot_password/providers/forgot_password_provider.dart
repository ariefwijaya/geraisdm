import 'package:geraisdm/constant/api_path.dart';
import 'package:geraisdm/modules/forgot_password/models/forgot_password_form_model.dart';
import 'package:geraisdm/modules/forgot_password/models/forgot_password_model.dart';
import 'package:geraisdm/modules/forgot_password/providers/forgot_password_provider_interface.dart';
import 'package:geraisdm/utils/services/rest_api_service/rest_api_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgotPasswordProviderInterface)
class ForgotPasswordProvider implements ForgotPasswordProviderInterface {
  final RestApiInterface restApiInterface;
  const ForgotPasswordProvider({required this.restApiInterface});
  @override
  Future<void> confirmReset(ForgotPasswordFormModel form) {
    return restApiInterface.post(ApiPath.resetPasswordConfirmation,
        body: form.toJson());
  }

  @override
  Future<ForgotPasswordModel> requestResetPassword(String username) async {
    final res = await restApiInterface
        .post(ApiPath.resetPasswordRequest, body: {"username": username});
    return ForgotPasswordModel.fromJson(res.data as Map<String, dynamic>);
  }
}
