import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_model.g.dart';

enum SearchActionType { url, screen, unknown }

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class SearchModel {
  final int id;
  final String name;
  final String? description;
  final String? icon;
  final String? category;
  final bool locked;
  @JsonKey(
      defaultValue: SearchActionType.unknown,
      unknownEnumValue: SearchActionType.unknown)
  final SearchActionType actionType;
  final String? path;

  const SearchModel(
      {required this.id,
      required this.name,
      this.description,
      this.icon,
      this.category,
      this.locked = true,
      required this.actionType,
      this.path});

  factory SearchModel.fromJson(Map<String, dynamic> json) =>
      _$SearchModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchModelToJson(this);
}
