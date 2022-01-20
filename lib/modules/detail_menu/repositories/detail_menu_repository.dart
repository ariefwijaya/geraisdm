import 'package:geraisdm/modules/detail_menu/models/detail_menu_model.dart';
import 'package:geraisdm/modules/detail_menu/models/detail_menu_tnc_model.dart';
import 'package:geraisdm/modules/detail_menu/providers/detail_menu_provider_interface.dart';
import 'package:geraisdm/modules/detail_menu/repositories/detail_menu_repository_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DetailMenuRepositoryInterface)
class DetailMenuRepository implements DetailMenuRepositoryInterface {
  final DetailMenuProviderInterface detailMenuProviderInterface;
  const DetailMenuRepository({required this.detailMenuProviderInterface});
  @override
  Future<DetailMenuModel> getDetail(int id) {
    return detailMenuProviderInterface.getDetail(id);
  }

  @override
  Future<DetailMenuTNCModel> getTNC(int id) {
    return detailMenuProviderInterface.getTNC(id);
  }
}
