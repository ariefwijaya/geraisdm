part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchStartSuccess extends SearchState {
  final PagingController<int, SearchModel> pagingController;
  const SearchStartSuccess(this.pagingController);

  @override
  List<Object> get props => [pagingController];
}

class SearchFailure extends SearchState {
  final Object error;
  final StackTrace stackTrace;

  const SearchFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}
