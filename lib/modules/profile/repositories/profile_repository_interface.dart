import 'package:geraisdm/modules/profile/models/profile_biodata_model.dart';
import 'package:geraisdm/modules/profile/models/profile_change_password_model.dart';

abstract class ProfileRepositoryInterface {
  Future<void> changePasssword(ProfileChangePasswordModel form);
  Future<List<ProfileBiodataModel>> getBiodata();
}
