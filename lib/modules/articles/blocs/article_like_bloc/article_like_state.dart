part of 'article_like_bloc.dart';

abstract class ArticleLikeState extends Equatable {
  const ArticleLikeState();

  @override
  List<Object> get props => [];
}

class ArticleLikeInitial extends ArticleLikeState {}

class ArticleLikeLoading extends ArticleLikeState {}

class ArticleLikeFailure extends ArticleLikeState {
  final Object error;
  final StackTrace stackTrace;

  const ArticleLikeFailure({required this.error, required this.stackTrace});
  @override
  List<Object> get props => [error, stackTrace];
}

class ArticleLikeSuccess extends ArticleLikeState {
  final bool liked;
  const ArticleLikeSuccess({required this.liked});
  @override
  List<Object> get props => [liked];
}
