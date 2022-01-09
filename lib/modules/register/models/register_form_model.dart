import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:geraisdm/utils/helpers/time_helper.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_form_model.g.dart';

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RegisterFormModel {
  final String? type;
  final String? username;
  final String? email;
  final String? fullName;
  final String? address;
  @JsonKey(toJson: _birthdayToJson)
  final DateTime? birthday;
  final String? handphone;
  final String? password;

  static String? _birthdayToJson(DateTime? data) {
    if (data == null) return null;
    return TimeHelper.dateTimeToYearMonthDay(data);
  }

  RegisterFormModel(
      {this.type,
      this.username,
      this.email,
      this.fullName,
      this.address,
      this.birthday,
      this.handphone,
      this.password});

  factory RegisterFormModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterFormModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterFormModelToJson(this);
}
