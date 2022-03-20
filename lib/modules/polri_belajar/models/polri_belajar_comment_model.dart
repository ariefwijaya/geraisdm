import 'package:json_annotation/json_annotation.dart';

part 'polri_belajar_comment_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PolriBelajarCommentModel {
  final String userName;
  final String? avatar;
  final String comment;
  final DateTime date;

  const PolriBelajarCommentModel(
      {required this.userName,
      this.avatar,
      required this.comment,
      required this.date});

  factory PolriBelajarCommentModel.fromJson(Map<String, dynamic> json) =>
      _$PolriBelajarCommentModelFromJson(json);
  Map<String, dynamic> toJson() => _$PolriBelajarCommentModelToJson(this);
}
