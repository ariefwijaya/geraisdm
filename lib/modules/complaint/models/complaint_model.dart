import 'package:json_annotation/json_annotation.dart';

part 'complaint_model.g.dart';

enum ComplaintActionType { screen, url, unknown }

@JsonSerializable(fieldRename: FieldRename.snake)
class ComplaintModel {
  final int id;
  final String title;
  final String ticketNumber;
  final DateTime createdDate;
  final String status;
  @JsonKey(
      defaultValue: ComplaintActionType.unknown,
      unknownEnumValue: ComplaintActionType.unknown)
  final ComplaintActionType actionType;
  final String? path;

  const ComplaintModel(
      {required this.id,
      this.path,
      required this.title,
      required this.actionType,
      required this.ticketNumber,
      required this.status,
      required this.createdDate});

  factory ComplaintModel.fromJson(Map<String, dynamic> json) =>
      _$ComplaintModelFromJson(json);
  Map<String, dynamic> toJson() => _$ComplaintModelToJson(this);
}
