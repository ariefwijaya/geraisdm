import 'package:geraisdm/modules/doc_viewer/models/doc_viewer_model.dart';
import 'package:geraisdm/modules/doc_viewer/models/doc_viewer_detail_model.dart';
import 'package:geraisdm/modules/doc_viewer/providers/doc_viewer_provider_interface.dart';
import 'package:geraisdm/modules/doc_viewer/repositories/doc_viewer_repository_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DocViewerRepositoryInterface)
class DocViewerRepository implements DocViewerRepositoryInterface {
  final DocViewerProviderInterface docViewerProviderInterface;

  const DocViewerRepository({required this.docViewerProviderInterface});
  @override
  Future<DocViewerDetailModel> getDetail(int id, String? type) {
    return docViewerProviderInterface.getDetail(id, type);
  }

  @override
  Future<List<DocViewerModel>> getList(int id, String? type) {
    return docViewerProviderInterface.getList(id, type);
  }
}
