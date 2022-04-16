part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchFetch extends SearchEvent {
  final int pageKey;
  const SearchFetch(this.pageKey);

  @override
  List<Object> get props => [pageKey];
}

class SearchStarted extends SearchEvent {}

class SearchRefresh extends SearchEvent {
  final String? query;
  const SearchRefresh({this.query});
  @override
  List<Object?> get props => [query];
}
