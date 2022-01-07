import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'onboarding_model.g.dart';

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class OnboardingModel {
  final String titleKey;
  final String? descriptionKey;
  final String? imagePath;

  OnboardingModel(
      {required this.titleKey, this.descriptionKey, this.imagePath});

  factory OnboardingModel.fromJson(Map<String, dynamic> json) =>
      _$OnboardingModelFromJson(json);
  Map<String, dynamic> toJson() => _$OnboardingModelToJson(this);
}
