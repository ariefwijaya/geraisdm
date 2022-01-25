import 'package:geraisdm/constant/api_path.dart';
import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/articles/models/article_model.dart';
import 'package:geraisdm/modules/articles/providers/article_provider_interface.dart';
import 'package:geraisdm/utils/services/rest_api_service/rest_api_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ArticleProviderInterface)
class ArticleProvider implements ArticleProviderInterface {
  final RestApiInterface restApi;
  ArticleProvider({required this.restApi});
  @override
  Future<List<ArticleModel>> getArticle(
      {PaginationControlModel? filter}) async {
    final res = await restApi.get(ApiPath.article, body: filter?.toJson());
    return (res.data as List<dynamic>)
        .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ArticleModel> getArticleById(int id) async {
    final res = await restApi.get("${ApiPath.article}/$id");
    return ArticleModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<void> toggleLiked(int id, {required bool liked}) {
    return restApi.post(ApiPath.articleLiked + "/$id", body: {"liked": liked});
  }
}
