import 'package:geraisdm/modules/home_layout/models/layout_config_model.dart';

abstract class HomeLayoutProviderInterface {
  Future<LayoutConfigModel> getConfigToggles();
}
