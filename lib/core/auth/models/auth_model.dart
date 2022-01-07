import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

@CopyWith()
@JsonSerializable()
class AuthSessionModel {
  @JsonKey(name: "x-token")
  final String xToken;
  final String uid;
  final String? deviceToken;
  @JsonKey(defaultValue: false)
  final bool isLoggedIn;

  AuthSessionModel({
    required this.uid,
    required this.xToken,
    this.deviceToken,
    required this.isLoggedIn,
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthSessionModelToJson(this);
}
