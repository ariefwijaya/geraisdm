part of 'register_activation_bloc.dart';

abstract class RegisterActivationState extends Equatable {
  const RegisterActivationState();

  @override
  List<Object> get props => [];
}

class RegisterActivationInitial extends RegisterActivationState {}

class RegisterActivationLoading extends RegisterActivationState {}

class RegisterActivationOTPWrong extends RegisterActivationState {}

class RegisterActivationOTPExpired extends RegisterActivationState {}

class RegisterActivationBadRequest extends RegisterActivationState {}

class RegisterActivationBirthdayWrong extends RegisterActivationState {}

class RegisterActivationFailure extends RegisterActivationState {
  final Object error;
  final StackTrace stackTrace;

  const RegisterActivationFailure(
      {required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class RegisterActivationSuccess extends RegisterActivationState {}
