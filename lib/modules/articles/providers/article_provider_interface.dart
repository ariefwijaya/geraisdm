import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/articles/models/article_model.dart';

abstract class ArticleProviderInterface {
  Future<List<ArticleModel>> getArticle({PaginationControlModel? filter});

  Future<ArticleModel> getArticleById(int id);

  Future<void> toggleLiked(int id, {required bool liked});
}
