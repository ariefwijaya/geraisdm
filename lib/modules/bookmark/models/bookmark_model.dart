import 'package:json_annotation/json_annotation.dart';

part 'bookmark_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BookmarkModel {
  final int id;
  final String? image;
  final String title;
  final String? description;
  final DateTime date;
  final String author;
  final String? content;

  @JsonKey(
      defaultValue: BookmarkActionType.unknown,
      unknownEnumValue: BookmarkActionType.unknown)
  final BookmarkActionType actionType;
  final String? path;

  const BookmarkModel(
      {required this.id,
      this.image,
      this.path,
      required this.title,
      required this.actionType,
      required this.date,
      required this.author,
      this.description,
      this.content});

  factory BookmarkModel.fromJson(Map<String, dynamic> json) =>
      _$BookmarkModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookmarkModelToJson(this);
}

enum BookmarkActionType { url, screen, unknown }
