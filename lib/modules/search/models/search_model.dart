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
  @JsonKey(defaultValue: true)
  final bool pathPrefixMatch;

  const SearchModel(
      {required this.id,
      required this.name,
      this.description,
      this.icon,
      this.category,
      this.locked = true,
      required this.actionType,
      this.path,
      required this.pathPrefixMatch});

  factory SearchModel.fromJson(Map<String, dynamic> json) =>
      _$SearchModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchModelToJson(this);
}
