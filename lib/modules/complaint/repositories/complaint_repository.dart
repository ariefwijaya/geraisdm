import 'package:geraisdm/modules/complaint/models/complaint_model.dart';
import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/complaint/providers/complaint_provider_interface.dart';
import 'package:geraisdm/modules/complaint/repositories/complaint_repository_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ComplaintRepositoryInterface)
class ComplaintRepository implements ComplaintRepositoryInterface {
  final ComplaintProviderInterface complaintProviderInterface;
  const ComplaintRepository({required this.complaintProviderInterface});

  @override
  Future<List<ComplaintModel>> getComplaint({PaginationControlModel? filter}) {
    return complaintProviderInterface.getComplaint(filter: filter);
  }
}
