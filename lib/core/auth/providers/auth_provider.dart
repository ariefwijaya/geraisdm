import '../../../../constant/api_path.dart';
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
  Future<AuthUserModel> getUserData() async {
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
