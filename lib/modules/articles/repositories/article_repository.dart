import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/articles/models/article_model.dart';
import 'package:geraisdm/modules/articles/providers/article_provider_interface.dart';
import 'package:geraisdm/modules/articles/repositories/article_repository_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ArticleRepositoryInterface)
class ArticleRepository implements ArticleRepositoryInterface {
  final ArticleProviderInterface articleProvider;

  const ArticleRepository({required this.articleProvider});
  @override
  Future<List<ArticleModel>> getArticle(
      {PaginationControlModel? filter}) async {
    return articleProvider.getArticle(filter: filter);
  }

  @override
  Future<List<ArticleModel>> getHighlight() {
    return articleProvider.getArticle(
        filter: const PaginationControlModel(pageSize: 6, pageOffset: 0));
  }

  @override
  Future<ArticleModel> getArticleById(int id) {
    return articleProvider.getArticleById(id);
  }

  @override
  Future<void> toggleLiked(int id, {required bool liked}) {
    return articleProvider.toggleLiked(id, liked: liked);
  }
}
