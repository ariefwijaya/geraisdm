import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/search/models/search_model.dart';

abstract class SearchRepositoryInterface {
  Future<List<SearchModel>> getListByKeywords(
      {String? query, PaginationControlModel? filter});
}
