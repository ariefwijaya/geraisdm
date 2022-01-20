import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/inbox/models/inbox_detail_model.dart';
import 'package:geraisdm/modules/inbox/models/inbox_model.dart';

abstract class InboxRepositoryInterface {
  Future<List<InboxModel>> getInbox({PaginationControlModel? filter});
  Future<List<InboxDetailModel>> getInboxById(int id);
  Future<void> sendMessage(int id, String message);
}
