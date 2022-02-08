part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final ForgotPasswordModel data;
  const ForgotPasswordSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

class ForgotPasswordFailure extends ForgotPasswordState {
  final Object error;
  final StackTrace stackTrace;

  const ForgotPasswordFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class ForgotPasswordUserNotValid extends ForgotPasswordState {}
