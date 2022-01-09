part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterRequestOTP extends RegisterEvent {
  final String type;
  final String username;
  final String handphone;

  const RegisterRequestOTP(
      {required this.type, required this.username, required this.handphone});
  @override
  List<Object> get props => [type, username, handphone];
}
