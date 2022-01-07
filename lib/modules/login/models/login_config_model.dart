import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_config_model.g.dart';

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class LoginConfigModel {
  final bool enabledRegister;
  final bool enabledForgotPassword;
  final String? illustration;

  LoginConfigModel(
      {required this.enabledRegister,
      required this.enabledForgotPassword,
      this.illustration});

  factory LoginConfigModel.fromJson(Map<String, dynamic> json) =>
      _$LoginConfigModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginConfigModelToJson(this);
}
