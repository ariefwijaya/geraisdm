import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'form_submission_model.g.dart';

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class FormSubmissionModel {
  final int id;
  final String title;
  final List<FormSubmissionFieldModel> forms;

  const FormSubmissionModel(
      {required this.id, required this.title, required this.forms});

  factory FormSubmissionModel.fromJson(Map<String, dynamic> json) =>
      _$FormSubmissionModelFromJson(json);
  Map<String, dynamic> toJson() => _$FormSubmissionModelToJson(this);
}

enum FormSubmissionFieldType {
  select,
  @JsonValue("select_api")
  selectApi,
  text,
  textarea,
  @JsonValue("upload_file")
  uploadFile,
  password,
  email,
  unknown
}

@JsonSerializable(fieldRename: FieldRename.snake)
class FormSubmissionFieldModel {
  final int id;
  final String title;
  @JsonKey(
      defaultValue: FormSubmissionFieldType.unknown,
      unknownEnumValue: FormSubmissionFieldType.unknown)
  final FormSubmissionFieldType type;
  final String? hint;
  final String? argument;
  final String valueName;
  final bool enabled;
  final bool readonly;
  final bool required;
  final String? initialValue;

  const FormSubmissionFieldModel(
      {required this.id,
      required this.title,
      required this.type,
      this.hint,
      this.argument,
      required this.valueName,
      required this.enabled,
      required this.readonly,
      required this.required,
      this.initialValue});

  factory FormSubmissionFieldModel.fromJson(Map<String, dynamic> json) =>
      _$FormSubmissionFieldModelFromJson(json);
  Map<String, dynamic> toJson() => _$FormSubmissionFieldModelToJson(this);
}
