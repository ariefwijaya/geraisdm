import 'package:geraisdm/modules/home_layout/models/layout_config_model.dart';
import 'package:geraisdm/utils/services/remote_config_service/remote_config_service_interface.dart';
import 'package:injectable/injectable.dart';

import 'home_layout_provider_interface.dart';

@Injectable(as: HomeLayoutProviderInterface)
class HomeLayoutProvider implements HomeLayoutProviderInterface {
  final RemoteConfigServiceInterface remoteConfigService;
  const HomeLayoutProvider({required this.remoteConfigService});

  @override
  Future<LayoutConfigModel> getConfigToggles() async {
    final res = await remoteConfigService.getJson("home_layout");
    return LayoutConfigModel.fromJson(res);
  }
}
