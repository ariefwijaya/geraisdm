import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_change_password_model.g.dart';

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class ProfileChangePasswordModel {
  final String oldPassword;
  final String newPassword;
  ProfileChangePasswordModel({
    required this.oldPassword,
    required this.newPassword,
  });

  factory ProfileChangePasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileChangePasswordModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileChangePasswordModelToJson(this);
}
