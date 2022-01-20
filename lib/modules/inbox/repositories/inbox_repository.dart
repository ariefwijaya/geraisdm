import 'package:geraisdm/modules/inbox/models/inbox_model.dart';
import 'package:geraisdm/modules/inbox/models/inbox_detail_model.dart';
import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/inbox/providers/inbox_provider_interface.dart';
import 'package:geraisdm/modules/inbox/repositories/inbox_repository_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: InboxRepositoryInterface)
class InboxRepository implements InboxRepositoryInterface {
  final InboxProviderInterface inboxProviderInterface;
  const InboxRepository({required this.inboxProviderInterface});
  @override
  Future<List<InboxModel>> getInbox({PaginationControlModel? filter}) {
    return inboxProviderInterface.getInbox(filter: filter);
  }

  @override
  Future<List<InboxDetailModel>> getInboxById(int id) async {
    return inboxProviderInterface.getInboxById(id);
  }

  @override
  Future<void> sendMessage(int id, String message) {
    return inboxProviderInterface.sendMessage(id, message);
  }
}
