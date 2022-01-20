import 'package:geraisdm/constant/api_path.dart';
import 'package:geraisdm/modules/submenu/models/submenu_model.dart';
import 'package:geraisdm/modules/submenu/providers/submenu_provider_interface.dart';
import 'package:geraisdm/utils/services/rest_api_service/rest_api_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SubmenuProviderInterface)
class SubmenuProvider implements SubmenuProviderInterface {
  final RestApiInterface restApiInterface;
  const SubmenuProvider({required this.restApiInterface});
  @override
  Future<List<SubmenuModel>> getSubmenus(int id) async {
    final res = await restApiInterface.get(ApiPath.menuSublist + "/$id");

    return (res.data as List<dynamic>)
        .map((e) => SubmenuModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
