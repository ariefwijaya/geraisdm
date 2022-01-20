part of 'profile_password_bloc.dart';

abstract class ProfilePasswordState extends Equatable {
  const ProfilePasswordState();

  @override
  List<Object> get props => [];
}

class ProfilePasswordInitial extends ProfilePasswordState {}

class ProfilePasswordLoading extends ProfilePasswordState {}

class ProfilePasswordFailure extends ProfilePasswordState {
  final Object error;
  final StackTrace stackTrace;

  const ProfilePasswordFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class ProfilePasswordSuccess extends ProfilePasswordState {}

class ProfilePasswordInvalid extends ProfilePasswordState {}
