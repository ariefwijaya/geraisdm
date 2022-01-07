part of 'deeplink_bloc.dart';

abstract class DeeplinkState extends Equatable {
  const DeeplinkState();

  @override
  List<Object> get props => [];
}

class DeeplinkInitial extends DeeplinkState {}

class DeeplinkLoading extends DeeplinkState {}

class DeeplinkNoData extends DeeplinkState {}

class DeeplinkNavigated extends DeeplinkState {
  final String path;
  const DeeplinkNavigated({required this.path});

  @override
  List<Object> get props => [path];
}

class DeeplinkFailure extends DeeplinkState {
  final Object error;
  final StackTrace stackTrace;

  const DeeplinkFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}
