import 'package:copy_with_extension/copy_with_extension.dart';
import 'onboarding_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'onboarding_config_model.g.dart';

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class OnboardingConfigModel {
  final bool enabledSkip;
  final List<OnboardingModel> content;

  OnboardingConfigModel({required this.enabledSkip, required this.content});

  factory OnboardingConfigModel.fromJson(Map<String, dynamic> json) =>
      _$OnboardingConfigModelFromJson(json);
  Map<String, dynamic> toJson() => _$OnboardingConfigModelToJson(this);
}
