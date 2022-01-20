import 'package:json_annotation/json_annotation.dart';

part 'history_model.g.dart';

enum HistoryStatus {
  @JsonValue("ACCEPTED")
  accepted,
  @JsonValue("READ")
  read,
  @JsonValue("REJECTED")
  rejected,
  @JsonValue("WAITING")
  waiting,
  unknown
}

@JsonSerializable(fieldRename: FieldRename.snake)
class HistoryModel {
  final int id;
  final String serviceName;
  final DateTime createdDate;
  @JsonKey(
      defaultValue: HistoryStatus.unknown,
      unknownEnumValue: HistoryStatus.unknown)
  final HistoryStatus status;
  const HistoryModel(
      {required this.id,
      required this.serviceName,
      required this.createdDate,
      required this.status});

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}
