part of 'forgot_password_confirm_bloc.dart';

abstract class ForgotPasswordConfirmEvent extends Equatable {
  const ForgotPasswordConfirmEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordConfirmStart extends ForgotPasswordConfirmEvent {
  final ForgotPasswordFormModel form;
  const ForgotPasswordConfirmStart({required this.form});

  @override
  List<Object> get props => [form];
}
