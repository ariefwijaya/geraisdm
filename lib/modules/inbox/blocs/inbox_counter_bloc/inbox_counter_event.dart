part of 'inbox_counter_bloc.dart';

abstract class InboxCounterEvent extends Equatable {
  const InboxCounterEvent();

  @override
  List<Object?> get props => [];
}

class InboxCounterUnreadFetch extends InboxCounterEvent {
  final int? id;
  const InboxCounterUnreadFetch({this.id});

  @override
  List<Object?> get props => [id];
}

class InboxCounterSetAsReadStart extends InboxCounterEvent {
  final int? id;
  const InboxCounterSetAsReadStart({this.id});

  @override
  List<Object?> get props => [id];
}
