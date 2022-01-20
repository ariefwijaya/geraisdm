import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_menu_model.g.dart';

enum HomeMenuActionType { url, screen, unknown }

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class HomeMenuModel {
  final int id;
  final String name;
  final String? description;
  final String? icon;
  final bool locked;
  @JsonKey(
      defaultValue: HomeMenuActionType.unknown,
      unknownEnumValue: HomeMenuActionType.unknown)
  final HomeMenuActionType actionType;
  final String? path;

  const HomeMenuModel(
      {required this.id,
      required this.name,
      this.description,
      this.icon,
      this.locked = true,
      required this.actionType,
      this.path});

  factory HomeMenuModel.fromJson(Map<String, dynamic> json) =>
      _$HomeMenuModelFromJson(json);
  Map<String, dynamic> toJson() => _$HomeMenuModelToJson(this);
}
