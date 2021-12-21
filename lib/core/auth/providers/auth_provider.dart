import '../../../../constant/api_path.dart';
import '../../../../core/auth/models/auth_model.dart';
import '../../../../core/auth/models/user_model.dart';
import '../../../../core/auth/providers/auth_provider_interface.dart';
import '../../../../utils/services/rest_api_service/rest_api_interface.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthProviderInterface)
class AuthProvider implements AuthProviderInterface {
  final RestApiInterface restApi;
  final FirebaseMessaging firebaseMessaging;
  const AuthProvider({required this.restApi, required this.firebaseMessaging});

  @override
  Future<AuthSessionModel> getNewToken(String refreshToken) async {
    final response =
        await restApi.get(ApiPath.session, body: {"token": refreshToken});
    final jsonmap = <String, dynamic>{};
    response.headers.forEach((name, values) {
      jsonmap[name] = values[0];
    });

    final responseData = response.data as Map<String, dynamic>;
    jsonmap['uid'] = responseData['user_id'] as int;
    jsonmap['expires_in'] = responseData['expires_in'] != null
        ? int.tryParse(responseData['expires_in'] as String)
        : null;
    return AuthSessionModel.fromJson(jsonmap);
  }

  @override
  Future<AuthUserModel> getUserData(int userId) async {
    final res = await restApi.get(ApiPath.profile);
    final data = res.data as Map<String, dynamic>;
    return AuthUserModel.fromJson(data);
  }

  @override
  Future<void> logout() async {
    await restApi.get(ApiPath.logout);
    await firebaseMessaging.deleteToken();
  }
}
