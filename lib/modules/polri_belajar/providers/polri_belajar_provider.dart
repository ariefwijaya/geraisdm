import 'package:geraisdm/constant/api_path.dart';
import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/polri_belajar/models/polri_belajar_comment_model.dart';
import 'package:geraisdm/modules/polri_belajar/models/polri_belajar_model.dart';
import 'package:geraisdm/modules/polri_belajar/providers/polri_belajar_provider_interface.dart';
import 'package:geraisdm/utils/services/rest_api_service/rest_api_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PolriBelajarProviderInterface)
class PolriBelajarProvider implements PolriBelajarProviderInterface {
  final RestApiInterface restApi;
  PolriBelajarProvider({required this.restApi});
  @override
  Future<List<PolriBelajarModel>> getPolriBelajar(int refId,
      {PaginationControlModel? filter}) async {
    Map<String, dynamic> body = {"ref": refId};
    final filterData = filter?.toJson();
    if (filterData != null) {
      body.addAll(filterData);
    }
    final res = await restApi.get(ApiPath.polriBelajar, body: body);
    return (res.data as List<dynamic>)
        .map((e) => PolriBelajarModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<PolriBelajarModel> getPolriBelajarById(int id, int refId) async {
    final res =
        await restApi.get("${ApiPath.polriBelajar}/$id", body: {"ref": refId});
    return PolriBelajarModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<void> addComment(int id, int refId, String commentText) {
    return restApi.post("${ApiPath.polriBelajarAddComment}/$id",
        queryParameters: {"ref": refId}, body: {"text": commentText});
  }

  @override
  Future<List<PolriBelajarCommentModel>> getComments(int id, int refId) async {
    final res = await restApi
        .get(ApiPath.polriBelajarComment + "/$id", body: {"ref": refId});
    return (res.data as List<dynamic>)
        .map(
            (e) => PolriBelajarCommentModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
