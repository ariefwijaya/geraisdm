import 'package:geraisdm/constant/api_path.dart';
import 'package:geraisdm/modules/doc_viewer/models/doc_viewer_model.dart';
import 'package:geraisdm/modules/doc_viewer/models/doc_viewer_detail_model.dart';
import 'package:geraisdm/modules/doc_viewer/providers/doc_viewer_provider_interface.dart';
import 'package:geraisdm/utils/services/rest_api_service/rest_api_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DocViewerProviderInterface)
class DocViewerProvider implements DocViewerProviderInterface {
  final RestApiInterface restApiInterface;
  const DocViewerProvider({required this.restApiInterface});
  @override
  Future<DocViewerDetailModel> getDetail(int id, String? type) async {
    final res = await restApiInterface
        .get(ApiPath.docViewerDetail + "/$id", body: {"type": type});
    return DocViewerDetailModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<List<DocViewerModel>> getList(int id, String? type) async {
    final res = await restApiInterface
        .get(ApiPath.docViewerList + "/$id", body: {"type": type});
    return (res.data as List<dynamic>)
        .map((e) => DocViewerModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
