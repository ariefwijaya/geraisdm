import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ArticleModel {
  final int id;
  final String? image;
  final String title;
  final String? description;
  final DateTime date;
  final String author;
  final String? content;

  @JsonKey(
      defaultValue: ArticleActionType.unknown,
      unknownEnumValue: ArticleActionType.unknown)
  final ArticleActionType actionType;
  final String? path;
  @JsonKey(defaultValue: false)
  final bool liked;
  final String? linkShare;

  const ArticleModel(
      {required this.id,
      this.image,
      this.path,
      required this.title,
      required this.actionType,
      required this.date,
      required this.author,
      this.description,
      this.content,
      required this.liked,
      this.linkShare});

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}

enum ArticleActionType { url, screen, unknown }
