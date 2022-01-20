import 'package:geraisdm/modules/submenu/models/submenu_model.dart';
import 'package:geraisdm/modules/submenu/providers/submenu_provider_interface.dart';
import 'package:geraisdm/modules/submenu/repositories/submenu_repository_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SubmenuRepositoryInterface)
class SubmenuRepository implements SubmenuRepositoryInterface {
  final SubmenuProviderInterface submenuProviderInterface;

  const SubmenuRepository({required this.submenuProviderInterface});
  @override
  Future<List<SubmenuModel>> getSubmenus(int id) {
    return submenuProviderInterface.getSubmenus(id);
  }
}
