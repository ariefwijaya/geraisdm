part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterFailure extends RegisterState {
  final Object error;
  final StackTrace stackTrace;

  const RegisterFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class RegisterAlreadyRegistered extends RegisterState {}

class RegisterPhoneHasBeenUsed extends RegisterState {}

class RegisterNRPInvalid extends RegisterState {}

class RegisterNIKInvalid extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final int expiry;
  final int otpLength;
  const RegisterSuccess({required this.expiry, required this.otpLength});
  @override
  List<Object> get props => [expiry, otpLength];
}
