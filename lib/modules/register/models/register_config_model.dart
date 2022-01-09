import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_config_model.g.dart';

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterConfigModel {
  final bool enableLogin;
  final String? verificationTypeDefault;
  final String? illustrationRegister;
  final List<RegisterConfigTypeModel> verificationType;

  final List<RegisterConfigTypeModel> registerType;

  RegisterConfigModel(
      {required this.enableLogin,
      this.verificationTypeDefault,
      this.illustrationRegister,
      required this.verificationType,
      required this.registerType});

  factory RegisterConfigModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterConfigModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterConfigModelToJson(this);
}

//=========================
@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterConfigTypeModel {
  final String nameKey;
  final String value;
  final bool enabled;
  final bool readOnly;
  final String formId;
  final List<RegisterConfigFormModel> form;

  RegisterConfigTypeModel(
      {required this.nameKey,
      required this.value,
      required this.enabled,
      required this.readOnly,
      required this.formId,
      required this.form});

  factory RegisterConfigTypeModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterConfigTypeModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterConfigTypeModelToJson(this);
}

//===========================
enum RegisterConfigFormType {
  nrp,
  email,
  birthday,
  phone,
  password,
  nik,
  @JsonValue("full_name")
  fullName,
  address,
  unknown
}

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterConfigFormModel {
  @JsonKey(defaultValue: RegisterConfigFormType.unknown)
  final RegisterConfigFormType type;
  final String nameKey;
  final String hintKey;
  final bool required;
  final bool enabled;
  final bool readOnly;
  final String formId;

  RegisterConfigFormModel(
      {required this.type,
      required this.nameKey,
      required this.hintKey,
      required this.required,
      required this.enabled,
      required this.readOnly,
      required this.formId});

  factory RegisterConfigFormModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterConfigFormModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterConfigFormModelToJson(this);
}
