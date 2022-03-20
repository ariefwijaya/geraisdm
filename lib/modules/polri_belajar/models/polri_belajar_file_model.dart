import 'package:json_annotation/json_annotation.dart';

part 'polri_belajar_file_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PolriBelajarFileModel {
  @JsonKey(fromJson: _idFromJson)
  final int id;
  final String fileUrl;
  final String? idKey;

  const PolriBelajarFileModel(
      {required this.id, required this.fileUrl, this.idKey});

  static int _idFromJson(dynamic id) {
    if (id is String) {
      return int.parse(id);
    } else {
      return id;
    }
  }

  factory PolriBelajarFileModel.fromJson(Map<String, dynamic> json) =>
      _$PolriBelajarFileModelFromJson(json);
  Map<String, dynamic> toJson() => _$PolriBelajarFileModelToJson(this);
}
