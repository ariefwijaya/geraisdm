import '../../../../core/settings/models/environment_model.dart';
import '../../../../core/settings/repositories/app_update_repository_interface.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/core/settings/repositories/app_update_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'app_update_state.dart';

@injectable
class AppUpdateCubit extends Cubit<AppUpdateState> {
  final AppUpdateRepositoryInterface appUpdateRepository;
  final EnvironmentModel environmentModel;
  AppUpdateCubit(
      {required this.appUpdateRepository, required this.environmentModel})
      : super(AppUpdateInitial());

  Future<void> checkVersion() async {
    try {
      final resAppInfo = await appUpdateRepository.getAppInfo();
      final String currentVersion = environmentModel.appVersion;
      final String newVersion = resAppInfo.version;
      final String? releaseInfo = resAppInfo.releaseInfo;

      final bool isUpdateSkipped =
          await appUpdateRepository.isUpdateSkipped(currentVersion);

      final DateTime? skipDateTime =
          await appUpdateRepository.getSkipDate(currentVersion);
      // will remind user after skipped in 3 days
      bool isAlertAgain = resAppInfo.showUpdate;

      if (skipDateTime != null) {
        isAlertAgain = DateTime.now().difference(skipDateTime).inDays > 3;
      }

      if (resAppInfo.showUpdate && !isUpdateSkipped && isAlertAgain) {
        emit(AppUpdateShowed(
            force: resAppInfo.forceUpdate,
            currentVersion: currentVersion,
            newVersion: newVersion,
            releaseInfo: releaseInfo));
      } else {
        emit(AppUpdateNoNeed());
      }
    } catch (e, s) {
      emit(AppUpdateFailure(error: e, stackTrace: s));
    }
  }

  Future<void> skipUpdate() async {
    try {
      final currentVersion = environmentModel.appVersion;
      await appUpdateRepository.skipUpdate(currentVersion);
      await appUpdateRepository.skipDate(currentVersion);
      emit(AppUpdateSkipped());
    } catch (e, s) {
      emit(AppUpdateFailure(error: e, stackTrace: s));
    }
  }
}
