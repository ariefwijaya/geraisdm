part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailed extends LoginState {
  final Object error;
  final StackTrace stackTrace;
  const LoginFailed({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class LoginWrongPassword extends LoginState {}

class LoginBadRequest extends LoginState {}

class LoginNotRegistered extends LoginState {}
