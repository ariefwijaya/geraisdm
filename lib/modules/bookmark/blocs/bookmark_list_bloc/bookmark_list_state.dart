part of 'bookmark_list_bloc.dart';

abstract class BookmarkListState extends Equatable {
  const BookmarkListState();

  @override
  List<Object> get props => [];
}

class BookmarkListInitial extends BookmarkListState {}

class BookmarkListStartSuccess extends BookmarkListState {
  final PagingController<int, BookmarkModel> pagingController;
  const BookmarkListStartSuccess(this.pagingController);

  @override
  List<Object> get props => [pagingController];
}

class BookmarkListFailure extends BookmarkListState {
  final Object error;
  final StackTrace stackTrace;

  const BookmarkListFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}
