import 'package:geraisdm/modules/form_submission/models/form_selection_model.dart';
import 'package:geraisdm/modules/form_submission/models/form_submission_model.dart';
import 'package:geraisdm/modules/form_submission/providers/form_submission_provider_interface.dart';
import 'package:geraisdm/modules/form_submission/repositories/form_submission_repository_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FormSubmissionRepositoryInterface)
class FormSubmissionRepository implements FormSubmissionRepositoryInterface {
  final FormSubmissionProviderInterface formSubmissionProviderInterface;

  const FormSubmissionRepository(
      {required this.formSubmissionProviderInterface});
  @override
  Future<FormSubmissionModel> getForm(int id) {
    return formSubmissionProviderInterface.getForm(id);
  }

  @override
  Future<void> submit(int id, {required Map<String, dynamic> form}) {
    return formSubmissionProviderInterface.submit(id, form: form);
  }

  @override
  Future<List<FormSelectionModel>> getSelections(String url) {
    return formSubmissionProviderInterface.getSelections(url);
  }
}
