import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_otp_model.g.dart';

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterOTPModel {
  final int otpLength;
  final int expiry;

  RegisterOTPModel({
    required this.otpLength,
    required this.expiry,
  });

  factory RegisterOTPModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterOTPModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterOTPModelToJson(this);
}
