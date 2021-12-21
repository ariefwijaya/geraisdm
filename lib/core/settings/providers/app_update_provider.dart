import '../../../../constant/api_path.dart';
import '../../../../core/settings/models/app_update_model.dart';
import '../../../../core/settings/providers/app_update_provider_interface.dart';
import '../../../../utils/services/rest_api_service/rest_api_interface.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: AppUpdateProviderInterface)
class AppUpdateProvider implements AppUpdateProviderInterface {
  final SharedPreferences sharedPreferences;
  final RestApiInterface restApi;

  const AppUpdateProvider(
      {required this.sharedPreferences, required this.restApi});
  @override
  Future<AppUpdateModel> getAppInfo() async {
    final result = await restApi.get(ApiPath.version);
    return AppUpdateModel.fromJson(result.data as Map<String, dynamic>);
  }

  @override
  Future<bool> isUpdateSkipped(String version) async {
    if (!sharedPreferences.containsKey(version)) return false;
    return sharedPreferences.getBool(version)!;
  }

  @override
  Future<void> skipUpdate(String version) async {
    sharedPreferences.setBool(version, true);
  }

  /// Time when Skip is set, this will be checked later to show the alert again after 3 days
  @override
  Future<void> skipDate(String version) async {
    sharedPreferences.setString(
        "${version}_skiptime", DateTime.now().toString());
  }

  @override
  Future<DateTime?> getSkipDate(String version) async {
    if (!sharedPreferences.containsKey("${version}_skiptime")) return null;
    final timeString = sharedPreferences.getString("${version}_skiptime");
    return DateTime.tryParse(timeString!);
  }
}
