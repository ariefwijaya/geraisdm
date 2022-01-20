import 'package:geraisdm/core/settings/models/api_res_upload_model.dart';

abstract class UploadFileRepositoryInterface {
  Future<ApiResUploadModel?> uploadFile({String? id});
}
