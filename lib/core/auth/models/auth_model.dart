import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

@CopyWith()
@JsonSerializable()
class AuthSessionModel {
  @JsonKey(name: "x-token")
  final String xToken;
  @JsonKey(name: "x-refresh-token")
  final String xRefreshToken;
  @JsonKey(name: "uid")
  final int uid;
  @JsonKey(name: "expires_in")
  final int expiresIn;
  @JsonKey(defaultValue: false)
  final bool isLoggedIn;
  final String? deviceToken;

  AuthSessionModel(
      {required this.uid,
      required this.xToken,
      required this.xRefreshToken,
      required this.expiresIn,
      required this.isLoggedIn,
      this.deviceToken});

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthSessionModelToJson(this);
}
