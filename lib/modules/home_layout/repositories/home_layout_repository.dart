import 'package:geraisdm/modules/home_layout/models/layout_config_model.dart';
import 'package:geraisdm/modules/home_layout/providers/home_layout_provider_interface.dart';
import 'package:injectable/injectable.dart';

import 'home_layout_repository_interface.dart';

@Injectable(as: HomeLayoutRepositoryInterface)
class HomeLayoutRepository implements HomeLayoutRepositoryInterface {
  final HomeLayoutProviderInterface homeLayoutProvider;
  const HomeLayoutRepository({required this.homeLayoutProvider});
  @override
  Future<LayoutConfigModel> getHomeLayoutConfig() {
    return homeLayoutProvider.getConfigToggles();
  }
}
