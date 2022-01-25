import 'dart:io';

import 'package:geraisdm/constant/api_path.dart';
import 'package:geraisdm/core/settings/models/api_res_upload_model.dart';
import 'package:geraisdm/modules/profile/models/profile_biodata_model.dart';
import 'package:geraisdm/modules/profile/models/profile_change_password_model.dart';
import 'package:geraisdm/modules/profile/providers/profile_provider_interface.dart';
import 'package:geraisdm/utils/services/rest_api_service/rest_api_interface.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileProviderInterface)
class ProfileProvider implements ProfileProviderInterface {
  final RestApiInterface restApiInterface;
  final ImagePicker imagePicker;
  const ProfileProvider(
      {required this.restApiInterface, required this.imagePicker});

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

  @override
  Future<XFile?> pickImageFromCamera() {
    return imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
        maxHeight: 1500,
        maxWidth: 1500);
  }

  @override
  Future<XFile?> pickImageFromGallery() {
    return imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
        maxHeight: 1500,
        maxWidth: 1500);
  }

  @override
  Future<ApiResUploadModel> uploadImage(File file) async {
    final result =
        await restApiInterface.uploadFile(ApiPath.avatar, file: file);
    return ApiResUploadModel.fromJson(result.data as Map<String, dynamic>);
  }
}
