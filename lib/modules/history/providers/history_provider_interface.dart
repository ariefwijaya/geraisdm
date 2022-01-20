import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/history/models/history_detail_model.dart';
import 'package:geraisdm/modules/history/models/history_model.dart';

abstract class HistoryProviderInterface {
  Future<List<HistoryModel>> getHistories({PaginationControlModel? filter});
  Future<HistoryDetailModel> getHistoryById(int id);
  Future<void> submitReview(int id, double value);
}
