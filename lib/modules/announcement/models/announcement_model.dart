import 'package:json_annotation/json_annotation.dart';

part 'announcement_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AnnouncementModel {
  final int id;
  final String? image;
  final String title;
  final String? description;
  final DateTime date;
  final String author;
  final String? content;
  @JsonKey(defaultValue: false)
  final bool liked;
  final String? linkShare;

  @JsonKey(
      defaultValue: AnnouncementActionType.unknown,
      unknownEnumValue: AnnouncementActionType.unknown)
  final AnnouncementActionType actionType;
  final String? path;

  const AnnouncementModel(
      {required this.id,
      this.image,
      this.path,
      required this.liked,
      required this.title,
      required this.actionType,
      required this.date,
      required this.author,
      this.description,
      this.content,
      this.linkShare});

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementModelFromJson(json);
  Map<String, dynamic> toJson() => _$AnnouncementModelToJson(this);
}

enum AnnouncementActionType { url, screen, unknown }
