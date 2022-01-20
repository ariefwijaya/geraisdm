import 'package:geraisdm/modules/history/models/history_detail_model.dart';
import 'package:geraisdm/modules/history/models/history_model.dart';
import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/history/providers/history_provider_interface.dart';
import 'package:geraisdm/modules/history/repositories/history_repository_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HistoryRepositoryInterface)
class HistoryRepository implements HistoryRepositoryInterface {
  final HistoryProviderInterface historyProviderInterface;
  const HistoryRepository({required this.historyProviderInterface});
  @override
  Future<List<HistoryModel>> getHistories({PaginationControlModel? filter}) {
    return historyProviderInterface.getHistories(filter: filter);
  }

  @override
  Future<HistoryDetailModel> getHistoryById(int id) {
    return historyProviderInterface.getHistoryById(id);
  }

  @override
  Future<void> submitReview(int id, double value) {
    return historyProviderInterface.submitReview(id, value);
  }
}
