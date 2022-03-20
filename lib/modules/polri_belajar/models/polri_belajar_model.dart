import 'package:geraisdm/modules/polri_belajar/models/polri_belajar_file_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'polri_belajar_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PolriBelajarModel {
  final int id;
  final String? image;
  final String title;
  final String? description;
  final DateTime date;
  final String author;
  final String? content;
  @JsonKey(defaultValue: false)
  final bool trending;
  final String? linkShare;
  @JsonKey(defaultValue: false)
  final bool comments;
  @JsonKey(defaultValue: [])
  final List<PolriBelajarFileModel> files;

  @JsonKey(
      defaultValue: PolriBelajarActionType.unknown,
      unknownEnumValue: PolriBelajarActionType.unknown)
  final PolriBelajarActionType actionType;
  final String? path;

  @JsonKey(
      defaultValue: PolriBelajarFileType.unknown,
      unknownEnumValue: PolriBelajarFileType.unknown)
  final PolriBelajarFileType fileType;

  const PolriBelajarModel(
      {required this.id,
      this.image,
      this.path,
      required this.trending,
      required this.title,
      required this.actionType,
      required this.date,
      required this.author,
      this.description,
      this.content,
      this.linkShare,
      required this.fileType,
      required this.comments,
      required this.files});

  factory PolriBelajarModel.fromJson(Map<String, dynamic> json) =>
      _$PolriBelajarModelFromJson(json);
  Map<String, dynamic> toJson() => _$PolriBelajarModelToJson(this);
}

enum PolriBelajarActionType { url, screen, unknown }

enum PolriBelajarFileType { pdf, image, video, unknown }
