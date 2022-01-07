part of 'deeplink_bloc.dart';

abstract class DeeplinkEvent extends Equatable {
  const DeeplinkEvent();

  @override
  List<Object> get props => [];
}

class DeeplinkStarted extends DeeplinkEvent {}

class DeeplinkStartNavigate extends DeeplinkEvent {
  final String path;
  const DeeplinkStartNavigate({required this.path});

  @override
  List<Object> get props => [path];
}

class DeeplinkThrowError extends DeeplinkEvent {
  final Object error;
  final StackTrace stackTrace;

  const DeeplinkThrowError({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}
