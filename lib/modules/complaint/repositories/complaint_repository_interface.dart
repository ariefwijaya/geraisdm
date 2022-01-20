import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/complaint/models/complaint_model.dart';

abstract class ComplaintRepositoryInterface {
  Future<List<ComplaintModel>> getComplaint({PaginationControlModel? filter});
}
