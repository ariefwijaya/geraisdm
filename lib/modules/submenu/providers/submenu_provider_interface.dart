import 'package:geraisdm/modules/submenu/models/submenu_model.dart';

abstract class SubmenuProviderInterface {
  Future<List<SubmenuModel>> getSubmenus(int id);
}
