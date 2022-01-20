part of 'inbox_bloc.dart';

abstract class InboxState extends Equatable {
  const InboxState();

  @override
  List<Object> get props => [];
}

class InboxInitial extends InboxState {}

class InboxLoading extends InboxState {}

class InboxFailure extends InboxState {
  final Object error;
  final StackTrace stackTrace;

  const InboxFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class InboxSuccess extends InboxState {
  final List<InboxDetailModel> data;

  const InboxSuccess({required this.data});

  @override
  List<Object> get props => [data];
}
