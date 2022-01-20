part of 'article_list_bloc.dart';

abstract class ArticleListState extends Equatable {
  const ArticleListState();

  @override
  List<Object> get props => [];
}

class ArticleListInitial extends ArticleListState {}

class ArticleListStartSuccess extends ArticleListState {
  final PagingController<int, ArticleModel> pagingController;
  const ArticleListStartSuccess(this.pagingController);

  @override
  List<Object> get props => [pagingController];
}

class ArticleListFailure extends ArticleListState {
  final Object error;
  final StackTrace stackTrace;

  const ArticleListFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}
