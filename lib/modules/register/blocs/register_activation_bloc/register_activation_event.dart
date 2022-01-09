part of 'register_activation_bloc.dart';

abstract class RegisterActivationEvent extends Equatable {
  const RegisterActivationEvent();

  @override
  List<Object> get props => [];
}

class RegisterActivationStart extends RegisterActivationEvent {
  final String otp;
  final RegisterFormModel data;

  const RegisterActivationStart({required this.otp, required this.data});

  @override
  List<Object> get props => [otp, data];
}
