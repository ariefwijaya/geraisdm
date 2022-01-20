import 'package:json_annotation/json_annotation.dart';

part 'home_config_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HomeConfigModel {
  final List<HomeSectionModel> sections;

  const HomeConfigModel({required this.sections});

  factory HomeConfigModel.fromJson(Map<String, dynamic> json) =>
      _$HomeConfigModelFromJson(json);
  Map<String, dynamic> toJson() => _$HomeConfigModelToJson(this);
}

enum HomeSectionType {
  @JsonValue("article_banner")
  articleBanner,
  @JsonValue("menu_list")
  menuList,
  menuAdditional,
  announcement,
  divider,
  unknown
}

@JsonSerializable(fieldRename: FieldRename.snake)
class HomeSectionModel {
  @JsonKey(
      defaultValue: HomeSectionType.unknown,
      unknownEnumValue: HomeSectionType.unknown)
  final HomeSectionType name;
  @JsonKey(defaultValue: false)
  final bool enable;
  final SectionConfigModel? config;

  const HomeSectionModel(
      {required this.name, required this.enable, this.config});

  factory HomeSectionModel.fromJson(Map<String, dynamic> json) =>
      _$HomeSectionModelFromJson(json);
  Map<String, dynamic> toJson() => _$HomeSectionModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SectionConfigModel {
  final bool? enableActionButton;
  final int? maxItem;
  final double? size;

  SectionConfigModel({this.enableActionButton, this.maxItem, this.size});

  factory SectionConfigModel.fromJson(Map<String, dynamic> json) =>
      _$SectionConfigModelFromJson(json);
  Map<String, dynamic> toJson() => _$SectionConfigModelToJson(this);
}
