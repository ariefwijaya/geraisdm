part of 'inbox_list_bloc.dart';

abstract class InboxListEvent extends Equatable {
  const InboxListEvent();

  @override
  List<Object> get props => [];
}

class InboxListFetch extends InboxListEvent {
  final int pageKey;
  const InboxListFetch(this.pageKey);

  @override
  List<Object> get props => [pageKey];
}

class InboxListStarted extends InboxListEvent {}

class InboxRefresh extends InboxListEvent {}
