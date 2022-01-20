import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/articles/models/article_model.dart';
import 'package:geraisdm/modules/articles/repositories/article_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'article_event.dart';
part 'article_state.dart';

@injectable
class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepositoryInterface articleRepository;

  ArticleBloc({required this.articleRepository}) : super(ArticleInitial()) {
    on<ArticleFetchDetail>((event, emit) async {
      try {
        emit(ArticleLoading());
        final res = await articleRepository.getArticleById(event.id);
        emit(ArticleDetailSuccess(data: res));
      } catch (e, s) {
        emit(ArticleFailure(error: e, stackTrace: s));
      }
    });
  }
}
