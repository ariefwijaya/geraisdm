import 'dart:io';

import 'package:geraisdm/core/settings/models/api_res_upload_model.dart';
import 'package:geraisdm/modules/profile/models/profile_biodata_model.dart';
import 'package:geraisdm/modules/profile/models/profile_change_password_model.dart';
import 'package:image_picker/image_picker.dart';

abstract class ProfileProviderInterface {
  Future<void> changePasssword(ProfileChangePasswordModel form);
  Future<List<ProfileBiodataModel>> getBiodata();
  Future<XFile?> pickImageFromCamera();
  Future<XFile?> pickImageFromGallery();
  Future<ApiResUploadModel> uploadImage(File file);
}
