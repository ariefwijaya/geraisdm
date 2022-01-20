part of 'article_like_bloc.dart';

abstract class ArticleLikeEvent extends Equatable {
  const ArticleLikeEvent();

  @override
  List<Object> get props => [];
}

class ArticleLikeStart extends ArticleLikeEvent {
  final int id;
  final bool like;
  const ArticleLikeStart({required this.id, required this.like});

  @override
  List<Object> get props => [id, like];
}
