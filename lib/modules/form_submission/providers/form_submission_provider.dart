import 'package:geraisdm/constant/api_path.dart';
import 'package:geraisdm/modules/form_submission/models/form_selection_model.dart';
import 'package:geraisdm/modules/form_submission/models/form_submission_model.dart';
import 'package:geraisdm/modules/form_submission/providers/form_submission_provider_interface.dart';
import 'package:geraisdm/utils/services/rest_api_service/rest_api_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FormSubmissionProviderInterface)
class FormSubmissionProvider implements FormSubmissionProviderInterface {
  final RestApiInterface restApiInterface;
  const FormSubmissionProvider({required this.restApiInterface});

  @override
  Future<FormSubmissionModel> getForm(int id) async {
    final res = await restApiInterface.get(ApiPath.formField + "/$id");
    return FormSubmissionModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<void> submit(int id, {required Map<String, dynamic> form}) {
    return restApiInterface.post(ApiPath.formFieldSubmit + "/$id", body: form);
  }

  @override
  Future<List<FormSelectionModel>> getSelections(String url) async {
    final res = await restApiInterface.get(url);
    return (res.data as List<dynamic>)
        .map((e) => FormSelectionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
