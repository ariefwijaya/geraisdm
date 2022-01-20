part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileFailure extends ProfileState {
  final Object error;
  final StackTrace stackTrace;

  const ProfileFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class ProfileSuccess extends ProfileState {
  final AuthUserModel data;

  const ProfileSuccess({required this.data});

  @override
  List<Object> get props => [data];
}
