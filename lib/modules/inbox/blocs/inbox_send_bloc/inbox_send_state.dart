part of 'inbox_send_bloc.dart';

abstract class InboxSendState extends Equatable {
  const InboxSendState();

  @override
  List<Object> get props => [];
}

class InboxSendInitial extends InboxSendState {}

class InboxSendLoading extends InboxSendState {}

class InboxSendFailure extends InboxSendState {
  final Object error;
  final StackTrace stackTrace;

  const InboxSendFailure({required this.error, required this.stackTrace});
  @override
  List<Object> get props => [error, stackTrace];
}

class InboxSendSuccess extends InboxSendState {
  final String message;
  const InboxSendSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
