import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/polri_belajar/models/polri_belajar_model.dart';
import 'package:geraisdm/modules/polri_belajar/models/polri_belajar_comment_model.dart';
import 'package:geraisdm/modules/polri_belajar/providers/polri_belajar_provider_interface.dart';
import 'package:geraisdm/modules/polri_belajar/repositories/polri_belajar_repository_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PolriBelajarRepositoryInterface)
class PolriBelajarRepository implements PolriBelajarRepositoryInterface {
  final PolriBelajarProviderInterface polriBelajarProvider;

  const PolriBelajarRepository({required this.polriBelajarProvider});

  @override
  Future<void> addComment(int id, int refId, String commentText) {
    return polriBelajarProvider.addComment(id, refId, commentText);
  }

  @override
  Future<List<PolriBelajarCommentModel>> getComments(int id, int refId) {
    return polriBelajarProvider.getComments(id, refId);
  }

  @override
  Future<List<PolriBelajarModel>> getPolriBelajar(int refId,
      {PaginationControlModel? filter}) {
    return polriBelajarProvider.getPolriBelajar(refId, filter: filter);
  }

  @override
  Future<PolriBelajarModel> getPolriBelajarById(int id, int refId) {
    return polriBelajarProvider.getPolriBelajarById(id, refId);
  }
}
