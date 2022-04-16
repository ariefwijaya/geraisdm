import 'package:geraisdm/constant/api_path.dart';
import 'package:geraisdm/modules/search/models/search_model.dart';
import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/search/providers/search_provider_interface.dart';
import 'package:geraisdm/utils/services/rest_api_service/rest_api_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SearchProviderInterface)
class SearchProvider implements SearchProviderInterface {
  final RestApiInterface restApi;

  const SearchProvider({required this.restApi});

  @override
  Future<List<SearchModel>> getListByKeywords(
      {String? query, PaginationControlModel? filter}) async {
    Map<String, dynamic> filterQuery = {"q": query};
    if (filter != null) {
      filterQuery.addAll(filter.toJson());
    }

    final res = await restApi.get(ApiPath.search, body: filterQuery);
    return (res.data as List<dynamic>)
        .map((e) => SearchModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
