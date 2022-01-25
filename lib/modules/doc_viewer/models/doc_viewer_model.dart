import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doc_viewer_model.g.dart';

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class DocViewerModel {
  final int id;
  final String name;
  final DateTime date;
  final String? type;
  final String? icon;

  const DocViewerModel({
    required this.id,
    required this.name,
    required this.date,
    this.type,
    this.icon,
  });

  factory DocViewerModel.fromJson(Map<String, dynamic> json) =>
      _$DocViewerModelFromJson(json);
  Map<String, dynamic> toJson() => _$DocViewerModelToJson(this);
}
