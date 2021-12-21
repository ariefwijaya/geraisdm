part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStartedEv extends AuthEvent {}

class AuthLogoutEv extends AuthEvent {}

class AuthShowExpired extends AuthEvent {}
