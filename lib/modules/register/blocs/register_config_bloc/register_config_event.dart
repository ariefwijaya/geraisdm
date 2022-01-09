part of 'register_config_bloc.dart';

abstract class RegisterConfigEvent extends Equatable {
  const RegisterConfigEvent();

  @override
  List<Object> get props => [];
}

class RegisterConfigFetch extends RegisterConfigEvent {}
