import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

enum GenderType {
  @JsonValue("m")
  male,
  @JsonValue("f")
  female,
  @JsonValue(null)
  unknown
}

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class AuthUserModel {
  static DateTime? _dateOfBirthFromJson(String? date) {
    if (date == null) return null;
    final splitted = date.split("-");
    return DateTime.parse([splitted[2], splitted[1], splitted[0]].join("-"));
  }

  final int id;
  final String name;
  final String email;
  @JsonKey(fromJson: _dateOfBirthFromJson)
  final DateTime? dateOfBirth;
  final String? phoneNumber;
  final String? profilePic;
  final int? monthlyIncome;
  final String username;
  @JsonKey(defaultValue: [], name: "device_tokens")
  final List<String> tokens;
  final String? referrerUsername;
  final String? paydayDate;
  @JsonKey(unknownEnumValue: GenderType.unknown)
  final GenderType? gender;

  const AuthUserModel(
      {required this.id,
      required this.name,
      required this.email,
      this.dateOfBirth,
      this.phoneNumber,
      this.profilePic,
      required this.monthlyIncome,
      required this.username,
      required this.tokens,
      this.referrerUsername,
      this.paydayDate,
      this.gender});

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthUserModelToJson(this);
}
