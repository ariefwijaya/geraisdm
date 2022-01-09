import 'package:geraisdm/constant/api_path.dart';
import 'package:geraisdm/modules/register/models/register_form_model.dart';
import 'package:geraisdm/modules/register/models/register_config_model.dart';
import 'package:geraisdm/modules/register/models/register_otp_model.dart';
import 'package:geraisdm/modules/register/providers/register_provider_interface.dart';
import 'package:geraisdm/utils/services/remote_config_service/remote_config_service_interface.dart';
import 'package:geraisdm/utils/services/rest_api_service/rest_api_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RegisterProviderInterface)
class RegisterProvider implements RegisterProviderInterface {
  final RestApiInterface restApi;
  final RemoteConfigServiceInterface remoteConfigService;
  const RegisterProvider(
      {required this.restApi, required this.remoteConfigService});

  @override
  Future<RegisterConfigModel> getConfig() async {
    final res = await remoteConfigService.getJson("register_screen");
    return RegisterConfigModel.fromJson(res);
  }

  @override
  Future<void> register(
      {required String otp, required RegisterFormModel data}) {
    return restApi.post(ApiPath.register, body: data.toJson()..["otp"] = otp);
  }

  @override
  Future<RegisterOTPModel> requestVerification(
      {required String type,
      required String username,
      required String handphone}) async {
    final res = await restApi.post(ApiPath.verification,
        body: {"type": type, "username": username, "handphone": handphone});
    return RegisterOTPModel.fromJson(res.data as Map<String, dynamic>);
  }
}
