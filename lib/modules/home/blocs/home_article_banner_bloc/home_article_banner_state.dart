part of 'home_article_banner_bloc.dart';

abstract class HomeArticleBannerState extends Equatable {
  const HomeArticleBannerState();

  @override
  List<Object> get props => [];
}

class HomeArticleBannerInitial extends HomeArticleBannerState {}

class HomeArticleBannerLoading extends HomeArticleBannerState {}

class HomeArticleBannerFailure extends HomeArticleBannerState {
  final Object error;
  final StackTrace trace;
  const HomeArticleBannerFailure(this.error, this.trace);

  @override
  List<Object> get props => [error, trace];
}

class HomeArticleBannerSuccess extends HomeArticleBannerState {
  final List<ArticleModel> listData;

  const HomeArticleBannerSuccess({required this.listData});

  @override
  List<Object> get props => [listData];
}
