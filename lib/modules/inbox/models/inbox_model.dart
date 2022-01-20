import 'package:json_annotation/json_annotation.dart';

part 'inbox_model.g.dart';

enum InboxStatus {
  @JsonValue("TERKIRIM")
  delivered,
  @JsonValue("DIBACA")
  read,
  unknown
}

@JsonSerializable(fieldRename: FieldRename.snake)
class InboxModel {
  final int id;
  final String serviceName;
  final DateTime createdDate;
  @JsonKey(
      defaultValue: InboxStatus.unknown, unknownEnumValue: InboxStatus.unknown)
  final InboxStatus status;
  const InboxModel(
      {required this.id,
      required this.serviceName,
      required this.createdDate,
      required this.status});

  factory InboxModel.fromJson(Map<String, dynamic> json) =>
      _$InboxModelFromJson(json);
  Map<String, dynamic> toJson() => _$InboxModelToJson(this);
}
