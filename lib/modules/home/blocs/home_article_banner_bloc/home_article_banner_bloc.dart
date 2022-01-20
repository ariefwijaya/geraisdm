import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/articles/models/article_model.dart';
import 'package:geraisdm/modules/home/repositories/home_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'home_article_banner_event.dart';
part 'home_article_banner_state.dart';

@injectable
class HomeArticleBannerBloc
    extends Bloc<HomeArticleBannerEvent, HomeArticleBannerState> {
  final HomeRepositoryInterface homeRepositoryInterface;
  HomeArticleBannerBloc({required this.homeRepositoryInterface})
      : super(HomeArticleBannerInitial()) {
    on<HomeArticleBannerFetch>((event, emit) async {
      try {
        emit(HomeArticleBannerLoading());
        final res = await homeRepositoryInterface.getLatestArticles();
        emit(HomeArticleBannerSuccess(listData: res));
      } catch (e, s) {
        emit(HomeArticleBannerFailure(e, s));
      }
    });
  }
}
