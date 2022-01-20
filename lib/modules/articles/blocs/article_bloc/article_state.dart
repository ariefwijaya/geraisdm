part of 'article_bloc.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleDetailSuccess extends ArticleState {
  final ArticleModel data;
  const ArticleDetailSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class ArticleFailure extends ArticleState {
  final Object error;
  final StackTrace stackTrace;

  const ArticleFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}
