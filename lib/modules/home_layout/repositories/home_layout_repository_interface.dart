import '../models/layout_config_model.dart';

abstract class HomeLayoutRepositoryInterface {
  Future<LayoutConfigModel> getHomeLayoutConfig();
}
