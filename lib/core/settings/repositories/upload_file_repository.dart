import 'package:geraisdm/core/settings/models/api_res_upload_model.dart';
import 'package:geraisdm/core/settings/providers/upload_file_provider_interface.dart';
import 'package:geraisdm/core/settings/repositories/upload_file_repository_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UploadFileRepositoryInterface)
class UploadFileRepository implements UploadFileRepositoryInterface {
  final UploadFileProviderInterface uploadFileProvider;
  const UploadFileRepository({required this.uploadFileProvider});

  @override
  Future<ApiResUploadModel?> uploadFile({String? id}) async {
    final file = await uploadFileProvider.pickFile();
    if (file != null) {
      return uploadFileProvider.uploadFile(file, id: id);
    } else {
      return null;
    }
  }
}
