import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/articles/repositories/article_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'article_like_event.dart';
part 'article_like_state.dart';

@injectable
class ArticleLikeBloc extends Bloc<ArticleLikeEvent, ArticleLikeState> {
  final ArticleRepositoryInterface articleRepositoryInterface;
  ArticleLikeBloc({required this.articleRepositoryInterface})
      : super(ArticleLikeInitial()) {
    on<ArticleLikeStart>((event, emit) async {
      try {
        emit(ArticleLikeLoading());
        emit(ArticleLikeSuccess(liked: event.like));
        await articleRepositoryInterface.toggleLiked(event.id,
            liked: event.like);
      } catch (e) {
        emit(ArticleLikeSuccess(liked: !event.like));
      }
    });
  }
}
