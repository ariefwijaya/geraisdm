import 'package:geraisdm/modules/doc_viewer/models/doc_viewer_detail_model.dart';
import 'package:geraisdm/modules/doc_viewer/models/doc_viewer_model.dart';

abstract class DocViewerProviderInterface {
  Future<List<DocViewerModel>> getList(int id, String? type);
  Future<DocViewerDetailModel> getDetail(int id, String? type);
}
