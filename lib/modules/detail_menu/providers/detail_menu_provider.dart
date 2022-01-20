import 'package:geraisdm/constant/api_path.dart';
import 'package:geraisdm/modules/detail_menu/models/detail_menu_model.dart';
import 'package:geraisdm/modules/detail_menu/models/detail_menu_tnc_model.dart';
import 'package:geraisdm/modules/detail_menu/providers/detail_menu_provider_interface.dart';
import 'package:geraisdm/utils/services/rest_api_service/rest_api_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DetailMenuProviderInterface)
class DetailMenuProvider implements DetailMenuProviderInterface {
  final RestApiInterface restApiInterface;

  const DetailMenuProvider({required this.restApiInterface});
  @override
  Future<DetailMenuModel> getDetail(int id) async {
    final res = await restApiInterface.get(ApiPath.detailMenu + "/$id");
    return DetailMenuModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<DetailMenuTNCModel> getTNC(int id) async {
    final res = await restApiInterface.get(ApiPath.requirement + "/$id");
    return DetailMenuTNCModel.fromJson(res.data as Map<String, dynamic>);
  }
}
