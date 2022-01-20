part of 'inbox_list_bloc.dart';

abstract class InboxListState extends Equatable {
  const InboxListState();

  @override
  List<Object> get props => [];
}

class InboxListInitial extends InboxListState {}

class InboxListStartSuccess extends InboxListState {
  final PagingController<int, InboxModel> pagingController;
  const InboxListStartSuccess(this.pagingController);

  @override
  List<Object> get props => [pagingController];
}

class InboxListFailure extends InboxListState {
  final Object error;
  final StackTrace stackTrace;

  const InboxListFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}
