import 'package:geraisdm/modules/submenu/models/submenu_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detail_menu_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DetailMenuModel {
  final int id;
  final String? icon;
  final String title;
  final String subtitle;
  final String? description;
  final List<SubmenuModel> navigation;
  const DetailMenuModel(
      {required this.id,
      this.icon,
      required this.title,
      required this.subtitle,
      this.description,
      required this.navigation});

  factory DetailMenuModel.fromJson(Map<String, dynamic> json) =>
      _$DetailMenuModelFromJson(json);
  Map<String, dynamic> toJson() => _$DetailMenuModelToJson(this);
}
