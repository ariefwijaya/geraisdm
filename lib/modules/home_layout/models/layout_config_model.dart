import 'package:json_annotation/json_annotation.dart';

part 'layout_config_model.g.dart';

enum LayoutMenuType { history, bookmark, home, message, profile, unknown }

@JsonSerializable(fieldRename: FieldRename.snake)
class LayoutConfigModel {
  @JsonKey(
      defaultValue: LayoutMenuType.unknown,
      unknownEnumValue: LayoutMenuType.unknown)
  final LayoutMenuType highlightMenu;
  final bool enabledHighlightMenu;
  final List<MenusItemConfigModel> menus;

  const LayoutConfigModel(
      {required this.highlightMenu,
      required this.enabledHighlightMenu,
      required this.menus});

  factory LayoutConfigModel.fromJson(Map<String, dynamic> json) =>
      _$LayoutConfigModelFromJson(json);
  Map<String, dynamic> toJson() => _$LayoutConfigModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MenusItemConfigModel {
  @JsonKey(
      defaultValue: LayoutMenuType.unknown,
      unknownEnumValue: LayoutMenuType.unknown)
  final LayoutMenuType name;
  final bool visible;

  const MenusItemConfigModel({required this.name, required this.visible});

  factory MenusItemConfigModel.fromJson(Map<String, dynamic> json) =>
      _$MenusItemConfigModelFromJson(json);
  Map<String, dynamic> toJson() => _$MenusItemConfigModelToJson(this);
}
