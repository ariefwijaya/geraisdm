part of 'forgot_password_confirm_bloc.dart';

abstract class ForgotPasswordConfirmState extends Equatable {
  const ForgotPasswordConfirmState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordConfirmInitial extends ForgotPasswordConfirmState {}

class ForgotPasswordConfirmLoading extends ForgotPasswordConfirmState {}

class ForgotPasswordConfirmFailure extends ForgotPasswordConfirmState {
  final Object error;
  final StackTrace stackTrace;

  const ForgotPasswordConfirmFailure(
      {required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class ForgotPasswordConfirmSuccess extends ForgotPasswordConfirmState {}

class ForgotPasswordConfirmWrongOTP extends ForgotPasswordConfirmState {}

class ForgotPasswordConfirmExpiredOTP extends ForgotPasswordConfirmState {}
