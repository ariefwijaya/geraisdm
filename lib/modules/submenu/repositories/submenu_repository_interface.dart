import 'package:geraisdm/modules/submenu/models/submenu_model.dart';

abstract class SubmenuRepositoryInterface {
  Future<List<SubmenuModel>> getSubmenus(int id);
}
