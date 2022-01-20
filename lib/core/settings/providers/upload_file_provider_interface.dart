import 'dart:io';

import 'package:geraisdm/core/settings/models/api_res_upload_model.dart';

abstract class UploadFileProviderInterface {
  Future<File?> pickFile();
  Future<ApiResUploadModel> uploadFile(File file, {String? id});
}
