import 'dart:io';

import 'package:geraisdm/core/settings/models/api_res_upload_model.dart';
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

  @override
  Future<ApiResUploadModel?> uploadAvatarFromCamera() async {
    final image = await profileProviderInterface.pickImageFromCamera();
    if (image != null) {
      return profileProviderInterface.uploadImage(File(image.path));
    }
  }

  @override
  Future<ApiResUploadModel?> uploadAvatarFromGallery() async {
    final image = await profileProviderInterface.pickImageFromGallery();
    if (image != null) {
      return profileProviderInterface.uploadImage(File(image.path));
    }
  }
}
