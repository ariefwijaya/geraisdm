import 'package:geraisdm/modules/register/models/register_config_model.dart';
import 'package:geraisdm/modules/register/models/register_form_model.dart';
import 'package:geraisdm/modules/register/models/register_otp_model.dart';

abstract class RegisterRepositoryInterface {
  Future<RegisterConfigModel> getConfig();
  Future<void> register({required String otp, required RegisterFormModel data});
  Future<RegisterOTPModel> requestVerification(
      {required String type,
      required String username,
      required String handphone});
}
