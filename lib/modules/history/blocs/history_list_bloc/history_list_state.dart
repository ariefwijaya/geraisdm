part of 'history_list_bloc.dart';

abstract class HistoryListState extends Equatable {
  const HistoryListState();

  @override
  List<Object> get props => [];
}

class HistoryListInitial extends HistoryListState {}

class HistoryListStartSuccess extends HistoryListState {
  final PagingController<int, HistoryModel> pagingController;
  const HistoryListStartSuccess(this.pagingController);

  @override
  List<Object> get props => [pagingController];
}

class HistoryListFailure extends HistoryListState {
  final Object error;
  final StackTrace stackTrace;

  const HistoryListFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}
