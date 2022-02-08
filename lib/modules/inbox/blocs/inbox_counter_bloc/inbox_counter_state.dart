part of 'inbox_counter_bloc.dart';

abstract class InboxCounterState extends Equatable {
  const InboxCounterState();

  @override
  List<Object> get props => [];
}

class InboxCounterInitial extends InboxCounterState {}

class InboxCounterLoading extends InboxCounterState {}

class InboxCounterFailure extends InboxCounterState {
  final Object error;
  final StackTrace stackTrace;

  const InboxCounterFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class InboxCounterUnreadTotal extends InboxCounterState {
  final int total;

  const InboxCounterUnreadTotal({required this.total});

  @override
  List<Object> get props => [total];
}
