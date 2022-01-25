part of 'profile_avatar_update_bloc.dart';

abstract class ProfileAvatarUpdateState extends Equatable {
  const ProfileAvatarUpdateState();

  @override
  List<Object> get props => [];
}

class ProfileAvatarUpdateInitial extends ProfileAvatarUpdateState {}

class ProfileAvatarUpdateLoading extends ProfileAvatarUpdateState {}

class ProfileAvatarUpdateFailed extends ProfileAvatarUpdateState {
  final Object error;
  final StackTrace stackTrace;

  const ProfileAvatarUpdateFailed(
      {required this.error, required this.stackTrace});
  @override
  List<Object> get props => [error, stackTrace];
}

class ProfileAvatarUpdateSuccess extends ProfileAvatarUpdateState {
  final ApiResUploadModel data;

  const ProfileAvatarUpdateSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

class ProfileAvatarUpdateCancelled extends ProfileAvatarUpdateState {}
