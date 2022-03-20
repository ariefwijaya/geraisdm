import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/polri_belajar/models/polri_belajar_comment_model.dart';
import 'package:geraisdm/modules/polri_belajar/models/polri_belajar_model.dart';

abstract class PolriBelajarRepositoryInterface {
  Future<List<PolriBelajarModel>> getPolriBelajar(int refId,
      {PaginationControlModel? filter});

  Future<PolriBelajarModel> getPolriBelajarById(int id, int refId);
  Future<List<PolriBelajarCommentModel>> getComments(int id, int refId);
  Future<void> addComment(int id, int refId, String commentText);
}
