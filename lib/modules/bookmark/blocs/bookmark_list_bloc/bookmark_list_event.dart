part of 'bookmark_list_bloc.dart';

abstract class BookmarkListEvent extends Equatable {
  const BookmarkListEvent();

  @override
  List<Object> get props => [];
}

class BookmarkListFetch extends BookmarkListEvent {
  final int pageKey;
  const BookmarkListFetch(this.pageKey);

  @override
  List<Object> get props => [pageKey];
}

class BookmarkListStarted extends BookmarkListEvent {}

class BookmarkRefresh extends BookmarkListEvent {}
