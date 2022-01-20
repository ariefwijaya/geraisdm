import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:geraisdm/constant/api_path.dart';
import 'package:geraisdm/core/settings/models/api_res_upload_model.dart';
import 'package:geraisdm/core/settings/providers/upload_file_provider_interface.dart';
import 'package:geraisdm/utils/services/rest_api_service/rest_api_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UploadFileProviderInterface)
class UploadFileProvider extends UploadFileProviderInterface {
  final RestApiInterface restApiInterface;

  UploadFileProvider({required this.restApiInterface});

  @override
  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf', 'doc'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      return file;
    }
  }

  @override
  Future<ApiResUploadModel> uploadFile(File file) async {
    final result =
        await restApiInterface.uploadFile(ApiPath.uploadFile, file: file);
    return ApiResUploadModel.fromJson(result.data as Map<String, dynamic>);
  }
}
