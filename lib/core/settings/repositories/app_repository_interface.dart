import '../../../../config/themes/theme_config.dart';
import '../../../../core/settings/models/language_model.dart';

/// Class that Process App Settings that usually setup by user
abstract class AppRepositoryInterface {
  /// Return selected Language if any
  /// else return default selected languange in [AppSetting.defaultLanguage]
  Future<LanguageModel> getSelectedLanguage();

  /// Return selected Theme if any
  /// else return default selected Theme [AppSetting.defaultTheme]
  Future<AppTheme> getSelectedTheme();

  Future<void> setLanguage(SettingLanguageModel languageCode);

  Future<void> subscribeToRemoteConfig();
}
