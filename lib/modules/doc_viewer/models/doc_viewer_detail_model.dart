import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doc_viewer_detail_model.g.dart';

enum DocViewerFileType { pdf, image, video, unknown }

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class DocViewerDetailModel {
  final int id;
  @JsonKey(name: "title")
  final String name;
  @JsonKey(name: "content")
  final String description;
  final DateTime date;
  final String? icon;
  @JsonKey(defaultValue: [])
  final List<DocViewerFileModel> files;
  final String? linkShare;
  final String? image;
  @JsonKey(
      defaultValue: DocViewerFileType.unknown,
      unknownEnumValue: DocViewerFileType.unknown)
  final DocViewerFileType fileType;

  const DocViewerDetailModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.date,
      this.icon,
      required this.files,
      this.linkShare,
      this.image,
      required this.fileType});

  factory DocViewerDetailModel.fromJson(Map<String, dynamic> json) =>
      _$DocViewerDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$DocViewerDetailModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class DocViewerFileModel {
  @JsonKey(fromJson: _idFromJson)
  final int id;
  final String fileUrl;
  final String? idKey;

  const DocViewerFileModel(
      {required this.id, required this.fileUrl, this.idKey});

  static int _idFromJson(dynamic id) {
    if (id is String) {
      return int.parse(id);
    } else {
      return id;
    }
  }

  factory DocViewerFileModel.fromJson(Map<String, dynamic> json) =>
      _$DocViewerFileModelFromJson(json);
  Map<String, dynamic> toJson() => _$DocViewerFileModelToJson(this);
}
