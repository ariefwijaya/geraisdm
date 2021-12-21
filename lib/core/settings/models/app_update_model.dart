import 'package:json_annotation/json_annotation.dart';

part 'app_update_model.g.dart';

@JsonSerializable()
class AppUpdateModel {
  final bool forceUpdate;
  final bool showUpdate;
  final String version;
  final String? releaseInfo;

  const AppUpdateModel(
      {required this.forceUpdate,
      required this.showUpdate,
      required this.version,
      this.releaseInfo});

  factory AppUpdateModel.fromJson(Map<String, dynamic> json) =>
      _$AppUpdateModelFromJson(json);
  Map<String, dynamic> toJson() => _$AppUpdateModelToJson(this);
}
