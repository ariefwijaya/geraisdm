part of 'article_list_bloc.dart';

abstract class ArticleListEvent extends Equatable {
  const ArticleListEvent();

  @override
  List<Object> get props => [];
}

class ArticleListFetch extends ArticleListEvent {
  final int pageKey;
  const ArticleListFetch(this.pageKey);

  @override
  List<Object> get props => [pageKey];
}

class ArticleListStarted extends ArticleListEvent {}

class ArticleRefresh extends ArticleListEvent {}
