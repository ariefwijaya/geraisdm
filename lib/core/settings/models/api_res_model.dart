import '../../../../core/settings/models/api_error_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_res_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResModel<T> {
  @JsonKey(name: "error_code")
  final String? errorCode;
  final String? message;
  final String? log;
  final int headerCode;
  final T? content;

  ApiResModel(
      {this.errorCode,
      this.message,
      this.log,
      required this.headerCode,
      this.content});

  factory ApiResModel.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ApiResModelFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResModelToJson(this, toJsonT);

  ApiErrorModel get resError =>
      ApiErrorModel(errorCode: errorCode!, message: message);
}
