import 'package:catcher/core/catcher.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/settings/models/app_setting_model.dart';
import '../../../../core/settings/models/language_model.dart';
import '../../../../core/auth/repositories/auth_repository_interface.dart';
import '../../../../core/settings/repositories/app_repository_interface.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app_setting.dart';

part 'language_state.dart';

/// Persistent cubit to manage app Localization changes
@injectable
class LanguageCubit extends HydratedCubit<LanguageState> {
  final AppRepositoryInterface appRepository;
  final AuthRepositoryInterface authRepository;
  LanguageCubit(this.appRepository, this.authRepository)
      : super(LanguageState(AppSetting.defaultLanguage.languageCode));

  @override
  LanguageState? fromJson(Map<String, dynamic> json) {
    try {
      final String? languageCode = AppSettingModel.fromJson(json).languageCode;
      final stateLang = languageCode != null && languageCode.isNotEmpty
          ? LanguageState(AppSettingModel.fromJson(json).languageCode!)
          : null;
      if (stateLang != null) {
        appRepository
            .setLanguage(SettingLanguageModel(lang: stateLang.languageCode))
            .catchError((e, s) {
          Catcher.reportCheckedError(e, s);
        });
      }
      return stateLang;
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(LanguageState state) {
    try {
      return {"languageCode": state.languageCode};
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> onChange(Change<LanguageState> change) async {
    super.onChange(change);
    try {
      final language =
          SettingLanguageModel(lang: change.nextState.languageCode);
      await appRepository.setLanguage(language);
    } catch (e, s) {
      Catcher.reportCheckedError(e, s);
    }
  }

  void change(String languageCode) {
    emit(LanguageState(languageCode));
  }

  Future<void> init() async {
    emit(LanguageState(state.languageCode));
  }
}
