part of 'login_config_bloc.dart';

abstract class LoginConfigEvent extends Equatable {
  const LoginConfigEvent();

  @override
  List<Object> get props => [];
}

class LoginConfigFetch extends LoginConfigEvent {}
