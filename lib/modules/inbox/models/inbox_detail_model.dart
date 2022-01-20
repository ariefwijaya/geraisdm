import 'package:geraisdm/modules/inbox/models/inbox_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inbox_detail_model.g.dart';

enum InboxUserType { user, admin, unknown }

@JsonSerializable(fieldRename: FieldRename.snake)
class InboxDetailModel {
  final int id;
  final String message;
  final DateTime createdDate;
  @JsonKey(
      defaultValue: InboxStatus.unknown, unknownEnumValue: InboxStatus.unknown)
  final InboxStatus status;
  @JsonKey(
      defaultValue: InboxUserType.unknown,
      unknownEnumValue: InboxUserType.unknown)
  final InboxUserType type;

  const InboxDetailModel(
      {required this.id,
      required this.message,
      required this.createdDate,
      required this.status,
      required this.type});

  factory InboxDetailModel.fromJson(Map<String, dynamic> json) =>
      _$InboxDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$InboxDetailModelToJson(this);
}
