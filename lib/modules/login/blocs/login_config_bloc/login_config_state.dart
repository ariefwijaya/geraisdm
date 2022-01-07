part of 'login_config_bloc.dart';

abstract class LoginConfigState extends Equatable {
  const LoginConfigState();

  @override
  List<Object> get props => [];
}

class LoginConfigInitial extends LoginConfigState {}

class LoginConfigLoading extends LoginConfigState {}

class LoginConfigSuccess extends LoginConfigState {
  final LoginConfigModel config;

  const LoginConfigSuccess({required this.config});

  @override
  List<Object> get props => [config];
}

class LoginConfigFailure extends LoginConfigState {
  final Object error;
  final StackTrace stackTrace;

  const LoginConfigFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}
