import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geraisdm/constant/api_path.dart';
import 'package:geraisdm/core/settings/models/language_model.dart';
import '../../../../utils/services/rest_api_service/rest_api_interface.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_provider_interface.dart';

@Injectable(as: AppProviderInterface)
class AppProvider implements AppProviderInterface {
  final FirebaseMessaging firebaseMessaging;
  final RestApiInterface restApiService;
  final SharedPreferences sharedPreferences;
  AppProvider(
      {required this.restApiService,
      required this.firebaseMessaging,
      required this.sharedPreferences});

  @override
  Future<dynamic> getPersistentDataByKey(String key) async {
    return sharedPreferences.getString(key);
  }

  @override
  Future<void> setLanguage(SettingLanguageModel languageCode) async {
    await restApiService.patch(
      ApiPath.userSettings,
      body: languageCode.toJson(),
    );
  }

  @override
  Future<void> setLanguageToLocal(SettingLanguageModel languageCode) {
    return sharedPreferences.setString("languageCode", languageCode.lang);
  }

  @override
  Future<void> subscribeToRemoteConfig() {
    return firebaseMessaging.subscribeToTopic("PUSH_RC");
  }
}
