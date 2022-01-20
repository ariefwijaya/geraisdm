part of 'home_article_banner_bloc.dart';

abstract class HomeArticleBannerEvent extends Equatable {
  const HomeArticleBannerEvent();

  @override
  List<Object> get props => [];
}

class HomeArticleBannerFetch extends HomeArticleBannerEvent {}
