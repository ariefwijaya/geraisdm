part of 'register_config_bloc.dart';

abstract class RegisterConfigState extends Equatable {
  const RegisterConfigState();

  @override
  List<Object> get props => [];
}

class RegisterConfigInitial extends RegisterConfigState {}

class RegisterConfigLoading extends RegisterConfigState {}

class RegisterConfigFailure extends RegisterConfigState {
  final Object error;
  final StackTrace stackTrace;

  const RegisterConfigFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class RegisterConfigSuccess extends RegisterConfigState {
  final RegisterConfigModel config;

  const RegisterConfigSuccess({required this.config});

  @override
  List<Object> get props => [config];
}
