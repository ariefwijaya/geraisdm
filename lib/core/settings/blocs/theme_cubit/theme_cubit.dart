import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../config/themes/theme_config.dart';
import '../../../../core/settings/models/app_setting_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app_setting.dart';

part 'theme_state.dart';

/// Persistent cubit to manage app theme changes
@injectable
class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(AppSetting.defaultTheme));

  void changeTheme(AppTheme theme) => emit(ThemeState(theme));

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    try {
      return ThemeState(AppSettingModel.fromJson(json).appTheme!);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    try {
      final json = AppSettingModel(appTheme: state.theme).toJson();
      return {"appTheme": json['appTheme']};
    } catch (e) {
      return null;
    }
  }
}
