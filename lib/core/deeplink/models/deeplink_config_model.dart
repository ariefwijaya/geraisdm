import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'deeplink_config_model.g.dart';

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class DeeplinkConfigModel {
  final String uriPrefix;
  final String androidPackageName;
  final int androidMinimumVersion;
  final String iosBundleId;
  final String iosMinimumVersion;

  const DeeplinkConfigModel(
      {required this.uriPrefix,
      required this.androidPackageName,
      required this.androidMinimumVersion,
      required this.iosBundleId,
      required this.iosMinimumVersion});

  factory DeeplinkConfigModel.fromJson(Map<String, dynamic> json) =>
      _$DeeplinkConfigModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeeplinkConfigModelToJson(this);
}
