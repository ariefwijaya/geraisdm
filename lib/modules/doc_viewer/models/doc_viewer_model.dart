import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doc_viewer_model.g.dart';

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class DocViewerModel {
  final int id;
  @JsonKey(name: "title")
  final String name;
  final DateTime date;
  final String? type;
  final String? icon;
  @JsonKey(
      defaultValue: DocViewerActionType.unknown,
      unknownEnumValue: DocViewerActionType.unknown)
  final DocViewerActionType actionType;
  final String? path;

  const DocViewerModel(
      {required this.id,
      required this.name,
      required this.date,
      this.type,
      this.icon,
      required this.actionType,
      this.path});

  factory DocViewerModel.fromJson(Map<String, dynamic> json) =>
      _$DocViewerModelFromJson(json);
  Map<String, dynamic> toJson() => _$DocViewerModelToJson(this);
}

enum DocViewerFileType { pdf, image, video, unknown }

enum DocViewerActionType { url, screen, unknown }
