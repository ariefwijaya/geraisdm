import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../constant/api_path.dart';
import '../models/login_form_model.dart';
import '../models/login_config_model.dart';
import '../../../core/auth/models/auth_model.dart';
import 'login_provider_interface.dart';
import '../../../utils/services/remote_config_service/remote_config_service_interface.dart';
import '../../../utils/services/rest_api_service/rest_api_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginProviderInterface)
class LoginProvider implements LoginProviderInterface {
  final RestApiInterface restApi;
  final RemoteConfigServiceInterface remoteConfigService;
  final FirebaseMessaging firebaseMessaging;

  const LoginProvider(
      {required this.restApi,
      required this.remoteConfigService,
      required this.firebaseMessaging});

  @override
  Future<LoginConfigModel> getConfig() async {
    final res = await remoteConfigService.getJson("login_screen");
    return LoginConfigModel.fromJson(res);
  }

  @override
  Future<AuthSessionModel> login(LoginFormModel data) async {
    final response = await restApi.post(ApiPath.login, body: data.toJson());

    final jsonmap = <String, dynamic>{};
    response.headers.forEach((name, values) {
      jsonmap[name] = values[0];
    });
    final responseData = response.data as Map<String, dynamic>;
    jsonmap['uid'] = responseData['user_id'] as String;
    return AuthSessionModel.fromJson(jsonmap);
  }

  @override
  Future<void> setDeviceToken(String deviceToken) async {
    await restApi
        .post(ApiPath.deviceToken, body: {"device_token": deviceToken});
  }

  @override
  Future<String?> getDeviceToken() async {
    String? pushNotifToken;
    try {
      pushNotifToken = await firebaseMessaging.getToken();
    } catch (e) {
      pushNotifToken = null;
    }
    return pushNotifToken;
  }

  @override
  Future<bool> isUserExist(String username) async {
    final res =
        await restApi.get(ApiPath.lookupUser, body: {"username": username});
    return res.data['exist'] as bool;
  }
}
