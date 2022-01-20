import 'package:geraisdm/constant/api_path.dart';
import 'package:geraisdm/modules/complaint/models/complaint_model.dart';
import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/complaint/providers/complaint_provider_interface.dart';
import 'package:geraisdm/utils/services/rest_api_service/rest_api_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ComplaintProviderInterface)
class ComplaintProvider implements ComplaintProviderInterface {
  final RestApiInterface restApiInterface;
  const ComplaintProvider({required this.restApiInterface});
  @override
  Future<List<ComplaintModel>> getComplaint(
      {PaginationControlModel? filter}) async {
    final res =
        await restApiInterface.get(ApiPath.likes, body: filter?.toJson());
    return (res.data as List<dynamic>)
        .map((e) => ComplaintModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
