import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doc_viewer_detail_model.g.dart';

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class DocViewerDetailModel {
  final int id;
  final String name;
  final String description;
  final DateTime date;
  final String? icon;
  final List<DocViewerFileModel> files;
  final String? linkShare;

  const DocViewerDetailModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.date,
      this.icon,
      required this.files,
      this.linkShare});

  factory DocViewerDetailModel.fromJson(Map<String, dynamic> json) =>
      _$DocViewerDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$DocViewerDetailModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class DocViewerFileModel {
  final int id;
  final String fileUrl;

  const DocViewerFileModel({
    required this.id,
    required this.fileUrl,
  });

  factory DocViewerFileModel.fromJson(Map<String, dynamic> json) =>
      _$DocViewerFileModelFromJson(json);
  Map<String, dynamic> toJson() => _$DocViewerFileModelToJson(this);
}
