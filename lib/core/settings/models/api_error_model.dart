import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_error_model.g.dart';

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class ApiErrorModel extends Equatable implements Exception {
  final String errorCode;
  @JsonKey(defaultValue: "")
  final String? message;
  final int? statusCode;

  const ApiErrorModel({required this.errorCode, this.message, this.statusCode});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);
  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  @override
  List<Object?> get props => [errorCode, statusCode];
}
