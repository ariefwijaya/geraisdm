import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_model.g.dart';

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class ForgotPasswordModel {
  final int expiry;
  final int otpLength;

  const ForgotPasswordModel({
    required this.expiry,
    required this.otpLength,
  });

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordModelFromJson(json);
  Map<String, dynamic> toJson() => _$ForgotPasswordModelToJson(this);
}
