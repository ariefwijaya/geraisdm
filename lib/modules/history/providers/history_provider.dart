import 'package:geraisdm/constant/api_path.dart';
import 'package:geraisdm/modules/history/models/history_detail_model.dart';
import 'package:geraisdm/modules/history/models/history_model.dart';
import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/history/providers/history_provider_interface.dart';
import 'package:geraisdm/utils/services/rest_api_service/rest_api_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HistoryProviderInterface)
class HistoryProvider implements HistoryProviderInterface {
  final RestApiInterface restApiInterface;

  const HistoryProvider({required this.restApiInterface});
  @override
  Future<List<HistoryModel>> getHistories(
      {PaginationControlModel? filter}) async {
    final res =
        await restApiInterface.get(ApiPath.submission, body: filter?.toJson());
    return (res.data as List<dynamic>)
        .map((e) => HistoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<HistoryDetailModel> getHistoryById(int id) async {
    final res = await restApiInterface.get("${ApiPath.submission}/$id");
    return HistoryDetailModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<void> submitReview(int id, double value) {
    return restApiInterface.post(ApiPath.review,
        body: {"id_pengajuan": id, "value_kepuasan": value});
  }
}
