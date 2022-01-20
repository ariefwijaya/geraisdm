part of 'profile_password_bloc.dart';

abstract class ProfilePasswordEvent extends Equatable {
  const ProfilePasswordEvent();

  @override
  List<Object> get props => [];
}

class ProfilePasswordChange extends ProfilePasswordEvent {
  final ProfileChangePasswordModel form;
  const ProfilePasswordChange({required this.form});

  @override
  List<Object> get props => [form];
}
