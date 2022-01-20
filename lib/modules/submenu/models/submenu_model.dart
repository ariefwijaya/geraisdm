import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'submenu_model.g.dart';

enum SubmenuActionType { url, screen, unknown }

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class SubmenuModel {
  final int id;
  final String name;
  final String? description;
  final String? icon;
  final bool locked;
  @JsonKey(
      defaultValue: SubmenuActionType.unknown,
      unknownEnumValue: SubmenuActionType.unknown)
  final SubmenuActionType actionType;
  final String? path;

  const SubmenuModel(
      {required this.id,
      required this.name,
      this.description,
      this.icon,
      this.locked = true,
      required this.actionType,
      this.path});

  factory SubmenuModel.fromJson(Map<String, dynamic> json) =>
      _$SubmenuModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubmenuModelToJson(this);
}
