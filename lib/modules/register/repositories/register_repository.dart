import 'package:geraisdm/modules/register/models/register_form_model.dart';
import 'package:geraisdm/modules/register/models/register_config_model.dart';
import 'package:geraisdm/modules/register/models/register_otp_model.dart';
import 'package:geraisdm/modules/register/providers/register_provider_interface.dart';
import 'package:geraisdm/modules/register/repositories/register_repository_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterRepositoryInterface)
class RegisterRepository implements RegisterRepositoryInterface {
  final RegisterProviderInterface registerProvider;
  const RegisterRepository({required this.registerProvider});

  @override
  Future<RegisterConfigModel> getConfig() {
    return registerProvider.getConfig();
  }

  @override
  Future<void> register(
      {required String otp, required RegisterFormModel data}) {
    return registerProvider.register(otp: otp, data: data);
  }

  @override
  Future<RegisterOTPModel> requestVerification(
      {required String type,
      required String username,
      required String handphone}) {
    return registerProvider.requestVerification(
        type: type, handphone: handphone, username: username);
  }
}
