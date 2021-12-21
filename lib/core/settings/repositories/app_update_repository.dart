import '../../../../core/settings/models/app_update_model.dart';
import '../../../../core/settings/providers/app_update_provider_interface.dart';
import '../../../../core/settings/repositories/app_update_repository_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AppUpdateRepositoryInterface)
class AppUpdateRepository implements AppUpdateRepositoryInterface {
  final AppUpdateProviderInterface appUpdateProvider;

  const AppUpdateRepository({required this.appUpdateProvider});
  @override
  Future<AppUpdateModel> getAppInfo() {
    return appUpdateProvider.getAppInfo();
  }

  @override
  Future<DateTime?> getSkipDate(String version) {
    return appUpdateProvider.getSkipDate(version);
  }

  @override
  Future<bool> isUpdateSkipped(String version) {
    return appUpdateProvider.isUpdateSkipped(version);
  }

  @override
  Future<void> skipDate(String version) {
    return appUpdateProvider.skipDate(version);
  }

  @override
  Future<void> skipUpdate(String version) {
    return appUpdateProvider.skipUpdate(version);
  }
}
