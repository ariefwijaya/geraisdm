import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_res_upload_model.g.dart';

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class ApiResUploadModel extends Equatable {
  final String uploadedFile;
  final String uploadedFileUrl;

  const ApiResUploadModel(
      {required this.uploadedFile, required this.uploadedFileUrl});

  factory ApiResUploadModel.fromJson(Map<String, dynamic> json) =>
      _$ApiResUploadModelFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResUploadModelToJson(this);

  @override
  List<Object?> get props => [uploadedFile, uploadedFileUrl];
}
