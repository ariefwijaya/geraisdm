import 'package:json_annotation/json_annotation.dart';

part 'detail_menu_tnc_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DetailMenuTNCModel {
  final int id;
  final String? image;
  final String title;
  final String? content;
  final DateTime dateUpdated;
  final List<DetailMenuActionsModel> listActions;
  const DetailMenuTNCModel(
      {required this.id,
      this.image,
      required this.title,
      this.content,
      required this.dateUpdated,
      required this.listActions});

  factory DetailMenuTNCModel.fromJson(Map<String, dynamic> json) =>
      _$DetailMenuTNCModelFromJson(json);
  Map<String, dynamic> toJson() => _$DetailMenuTNCModelToJson(this);
}

enum DetailMenuActionType { screen, url, unknown }

@JsonSerializable(fieldRename: FieldRename.snake)
class DetailMenuActionsModel {
  final String name;
  @JsonKey(
      defaultValue: DetailMenuActionType.unknown,
      unknownEnumValue: DetailMenuActionType.unknown)
  final DetailMenuActionType actionType;
  final String? path;
  const DetailMenuActionsModel({
    required this.name,
    required this.actionType,
    this.path,
  });

  factory DetailMenuActionsModel.fromJson(Map<String, dynamic> json) =>
      _$DetailMenuActionsModelFromJson(json);
  Map<String, dynamic> toJson() => _$DetailMenuActionsModelToJson(this);
}
