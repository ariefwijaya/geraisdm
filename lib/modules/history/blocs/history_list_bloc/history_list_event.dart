part of 'history_list_bloc.dart';

abstract class HistoryListEvent extends Equatable {
  const HistoryListEvent();

  @override
  List<Object> get props => [];
}

class HistoryListFetch extends HistoryListEvent {
  final int pageKey;
  const HistoryListFetch(this.pageKey);

  @override
  List<Object> get props => [pageKey];
}

class HistoryListStarted extends HistoryListEvent {}

class HistoryRefresh extends HistoryListEvent {}
