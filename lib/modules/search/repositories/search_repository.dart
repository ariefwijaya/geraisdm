import 'package:geraisdm/modules/search/models/search_model.dart';
import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/search/providers/search_provider_interface.dart';
import 'package:geraisdm/modules/search/repositories/search_repository_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SearchRepositoryInterface)
class SearchRepository implements SearchRepositoryInterface {
  final SearchProviderInterface searchProviderInterface;
  const SearchRepository({required this.searchProviderInterface});

  @override
  Future<List<SearchModel>> getListByKeywords(
      {String? query, PaginationControlModel? filter}) {
    return searchProviderInterface.getListByKeywords(
        query: query, filter: filter);
  }
}
