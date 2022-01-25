import 'package:geraisdm/modules/form_submission/models/form_submission_model.dart';
import 'package:geraisdm/modules/history/models/history_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history_detail_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HistoryDetailModel {
  final int id;
  final String title;
  final DateTime createdDate;
  final List<String> fileDownload;
  final DateTime? updatedDate;
  @JsonKey(
      defaultValue: HistoryStatus.unknown,
      unknownEnumValue: HistoryStatus.unknown)
  final HistoryStatus status;
  final List<FormSubmissionFieldModel> forms;
  final double? rating;

  const HistoryDetailModel(
      {required this.id,
      required this.title,
      required this.createdDate,
      required this.fileDownload,
      this.updatedDate,
      required this.status,
      required this.forms,
      this.rating});

  factory HistoryDetailModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryDetailModelToJson(this);
}
