import 'package:geraisdm/constant/api_path.dart';
import 'package:geraisdm/modules/profile/models/profile_biodata_model.dart';
import 'package:geraisdm/modules/profile/models/profile_change_password_model.dart';
import 'package:geraisdm/modules/profile/providers/profile_provider_interface.dart';
import 'package:geraisdm/utils/services/rest_api_service/rest_api_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileProviderInterface)
class ProfileProvider implements ProfileProviderInterface {
  final RestApiInterface restApiInterface;
  const ProfileProvider({required this.restApiInterface});

  @override
  Future<void> changePasssword(ProfileChangePasswordModel form) {
    return restApiInterface.put(ApiPath.changePassword, body: form.toJson());
  }

  @override
  Future<List<ProfileBiodataModel>> getBiodata() async {
    final res = await restApiInterface.get(ApiPath.biodata);
    return (res.data as List<dynamic>)
        .map((e) => ProfileBiodataModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
