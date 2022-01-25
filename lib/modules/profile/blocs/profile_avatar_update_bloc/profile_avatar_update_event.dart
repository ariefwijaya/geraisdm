part of 'profile_avatar_update_bloc.dart';

abstract class ProfileAvatarUpdateEvent extends Equatable {
  const ProfileAvatarUpdateEvent();

  @override
  List<Object?> get props => [];
}

class ProfileAvatarUpdateCameraStarted extends ProfileAvatarUpdateEvent {}

class ProfileAvatarUpdateGalleryStarted extends ProfileAvatarUpdateEvent {}
