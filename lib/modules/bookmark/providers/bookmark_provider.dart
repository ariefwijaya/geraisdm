import 'package:geraisdm/constant/api_path.dart';
import 'package:geraisdm/modules/bookmark/models/bookmark_model.dart';
import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/bookmark/providers/bookmark_provider_interface.dart';
import 'package:geraisdm/utils/services/rest_api_service/rest_api_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BookmarkProviderInterface)
class BookmarkProvider implements BookmarkProviderInterface {
  final RestApiInterface restApiInterface;
  const BookmarkProvider({required this.restApiInterface});
  @override
  Future<List<BookmarkModel>> getBookmark(
      {PaginationControlModel? filter}) async {
    final res =
        await restApiInterface.get(ApiPath.likes, body: filter?.toJson());
    return (res.data as List<dynamic>)
        .map((e) => BookmarkModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
