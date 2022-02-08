import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_form_model.g.dart';

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class ForgotPasswordFormModel {
  final String username;
  final String otp;
  final String newPassword;

  const ForgotPasswordFormModel({
    required this.username,
    required this.otp,
    required this.newPassword,
  });

  factory ForgotPasswordFormModel.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordFormModelFromJson(json);
  Map<String, dynamic> toJson() => _$ForgotPasswordFormModelToJson(this);
}
