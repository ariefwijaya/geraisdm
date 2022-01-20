import 'package:geraisdm/modules/form_submission/models/form_selection_model.dart';
import 'package:geraisdm/modules/form_submission/models/form_submission_model.dart';

abstract class FormSubmissionRepositoryInterface {
  Future<FormSubmissionModel> getForm(int id);
  Future<void> submit(int id, {required Map<String, dynamic> form});
  Future<List<FormSelectionModel>> getSelections(String url);
}
