import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_biodata_model.g.dart';

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class ProfileBiodataModel {
  final String name;
  final String value;
  ProfileBiodataModel({
    required this.name,
    required this.value,
  });

  factory ProfileBiodataModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileBiodataModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileBiodataModelToJson(this);
}
