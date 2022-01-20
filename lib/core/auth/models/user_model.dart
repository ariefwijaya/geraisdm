import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:geraisdm/core/auth/models/personil_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

enum UserType {
  @JsonValue("UMUM")
  umum,
  @JsonValue("PNS")
  pns,
  @JsonValue("POLISI")
  polisi,
  unknown
}

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class AuthUserModel {
  final int poldaId;
  final int groupsId;

  /// nrp or nip
  final String employeeId;
  final String nik;
  final String hpNo;
  final DateTime birthday;
  final String address;

  final String fullName;
  final String shortName;
  @JsonKey(unknownEnumValue: UserType.unknown, defaultValue: UserType.unknown)
  final UserType accountType;
  final String? avatar;
  final String? email;
  final PersonilModel? dataPersonil;

  const AuthUserModel(
      {required this.poldaId,
      required this.groupsId,
      required this.employeeId,
      required this.nik,
      required this.hpNo,
      required this.birthday,
      required this.address,
      required this.fullName,
      required this.shortName,
      required this.accountType,
      this.avatar,
      this.email,
      this.dataPersonil});

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthUserModelToJson(this);
}
