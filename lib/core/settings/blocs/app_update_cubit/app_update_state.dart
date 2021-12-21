part of 'app_update_cubit.dart';

abstract class AppUpdateState extends Equatable {
  const AppUpdateState();

  @override
  List<Object?> get props => [];
}

class AppUpdateInitial extends AppUpdateState {}

class AppUpdateSkipped extends AppUpdateState {}

class AppUpdateNoNeed extends AppUpdateState {}

class AppUpdateShowed extends AppUpdateState {
  final bool force;
  final String currentVersion;
  final String newVersion;
  final String? releaseInfo;

  const AppUpdateShowed(
      {this.force = false,
      required this.currentVersion,
      required this.newVersion,
      this.releaseInfo});
  @override
  List<Object?> get props => [force, currentVersion, newVersion, releaseInfo];
}

class AppUpdateFailure extends AppUpdateState {
  final Object error;
  final StackTrace stackTrace;

  const AppUpdateFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}
