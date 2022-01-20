import 'package:geraisdm/modules/profile/models/profile_biodata_model.dart';
import 'package:geraisdm/modules/profile/models/profile_change_password_model.dart';
import 'package:geraisdm/modules/profile/providers/profile_provider_interface.dart';
import 'package:geraisdm/modules/profile/repositories/profile_repository_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepositoryInterface)
class ProfileRepository implements ProfileRepositoryInterface {
  final ProfileProviderInterface profileProviderInterface;

  const ProfileRepository({required this.profileProviderInterface});
  @override
  Future<void> changePasssword(ProfileChangePasswordModel form) {
    return profileProviderInterface.changePasssword(form);
  }

  @override
  Future<List<ProfileBiodataModel>> getBiodata() {
    return profileProviderInterface.getBiodata();
  }
}
