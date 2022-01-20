import 'package:geraisdm/modules/detail_menu/models/detail_menu_model.dart';
import 'package:geraisdm/modules/detail_menu/models/detail_menu_tnc_model.dart';

abstract class DetailMenuRepositoryInterface {
  Future<DetailMenuModel> getDetail(int id);
  Future<DetailMenuTNCModel> getTNC(int id);
}
