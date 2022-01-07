import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_form_model.g.dart';

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class LoginFormModel extends Equatable {
  final String username;
  final String password;

  const LoginFormModel({
    required this.username,
    required this.password,
  });

  factory LoginFormModel.fromJson(Map<String, dynamic> json) =>
      _$LoginFormModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginFormModelToJson(this);

  @override
  List<Object?> get props => [username, password];
}
