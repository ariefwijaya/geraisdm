import '../../../../core/settings/models/language_model.dart';

abstract class AppProviderInterface {
  /// Get NoSql Key Value pair persisent data,
  /// For Eg. Hydrated Bloc using hivedb
  Future<dynamic> getPersistentDataByKey(String key);
  Future<void> setLanguage(SettingLanguageModel languageCode);
  Future<void> setLanguageToLocal(SettingLanguageModel languageCode);

  Future<void> subscribeToRemoteConfig();
}
