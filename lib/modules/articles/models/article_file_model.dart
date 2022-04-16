import 'package:json_annotation/json_annotation.dart';

part 'article_file_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ArticleFileModel {
  @JsonKey(fromJson: _idFromJson)
  final int id;
  final String fileUrl;
  final String? idKey;

  const ArticleFileModel({required this.id, required this.fileUrl, this.idKey});

  static int _idFromJson(dynamic id) {
    if (id is String) {
      return int.parse(id);
    } else {
      return id;
    }
  }

  factory ArticleFileModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleFileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleFileModelToJson(this);
}
