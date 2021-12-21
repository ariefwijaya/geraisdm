import '../../../../config/themes/theme_config.dart';
import '../../../../core/app_setting.dart';
import '../../../../core/auth/providers/auth_local_provider_interface.dart';
import '../../../../core/settings/models/app_setting_model.dart';
import '../../../../core/settings/models/language_model.dart';
import '../../../../core/settings/providers/app_provider_interface.dart';
import '../../../../utils/helpers/connection_helper.dart';
import 'package:injectable/injectable.dart';

import 'app_repository_interface.dart';

@Singleton(as: AppRepositoryInterface)
class AppRepository implements AppRepositoryInterface {
  final AppProviderInterface appProvider;
  final AuthLocalProviderInterface authLocalProvider;
  const AppRepository(
      {required this.appProvider, required this.authLocalProvider});

  @override
  Future<LanguageModel> getSelectedLanguage() async {
    final langCode = await appProvider.getPersistentDataByKey("languageCode");
    return AppSetting.supportedLanguageList.firstWhere(
        (e) => e.languageCode == langCode,
        orElse: () => AppSetting.defaultLanguage);
  }

  @override
  Future<AppTheme> getSelectedTheme() async {
    final appTheme = await appProvider.getPersistentDataByKey("appTheme");
    if (appTheme == null) return AppSetting.defaultTheme;
    return AppSettingModel.fromJson({"appTheme": appTheme}).appTheme!;
  }

  @override
  Future<void> setLanguage(SettingLanguageModel languageCode) async {
    await appProvider.setLanguageToLocal(languageCode);
    final session = await authLocalProvider.getActiveSession();
    if (session != null && await ConnectionHelper.isNetworkOnline()) {
      await appProvider.setLanguage(languageCode);
    }
  }

  @override
  Future<void> subscribeToRemoteConfig() {
    return appProvider.subscribeToRemoteConfig();
  }
}
