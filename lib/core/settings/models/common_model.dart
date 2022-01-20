import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'common_model.g.dart';

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class PaginationControlModel {
  final int pageSize;
  final int pageOffset;

  const PaginationControlModel(
      {required this.pageSize, required this.pageOffset});

  factory PaginationControlModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationControlModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationControlModelToJson(this);
}
