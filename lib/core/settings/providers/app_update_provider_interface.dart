import '../../../../core/settings/models/app_update_model.dart';

abstract class AppUpdateProviderInterface {
  Future<AppUpdateModel> getAppInfo();

  Future<bool> isUpdateSkipped(String version);

  Future<void> skipUpdate(String version);

  /// Time when Skip is set, this will be checked later to show the alert again after 3 days
  Future<void> skipDate(String version);

  Future<DateTime?> getSkipDate(String version);
}
