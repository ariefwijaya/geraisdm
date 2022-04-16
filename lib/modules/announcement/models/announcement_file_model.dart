import 'package:json_annotation/json_annotation.dart';

part 'announcement_file_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AnnouncementFileModel {
  @JsonKey(fromJson: _idFromJson)
  final int id;
  final String fileUrl;
  final String? idKey;

  const AnnouncementFileModel(
      {required this.id, required this.fileUrl, this.idKey});

  static int _idFromJson(dynamic id) {
    if (id is String) {
      return int.parse(id);
    } else {
      return id;
    }
  }

  factory AnnouncementFileModel.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementFileModelFromJson(json);
  Map<String, dynamic> toJson() => _$AnnouncementFileModelToJson(this);
}
