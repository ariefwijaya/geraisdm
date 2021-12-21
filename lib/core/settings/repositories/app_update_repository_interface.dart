import '../../../../core/settings/models/app_update_model.dart';

abstract class AppUpdateRepositoryInterface {
  Future<AppUpdateModel> getAppInfo();

  Future<bool> isUpdateSkipped(String version);

  Future<void> skipUpdate(String version);

  Future<void> skipDate(String version);

  Future<DateTime?> getSkipDate(String version);
}
