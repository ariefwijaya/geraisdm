import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/inbox/models/inbox_detail_model.dart';
import 'package:geraisdm/modules/inbox/models/inbox_model.dart';

abstract class InboxProviderInterface {
  Future<List<InboxModel>> getInbox({PaginationControlModel? filter});
  Future<List<InboxDetailModel>> getInboxById(int id);
  Future<void> sendMessage(int id, String message);
  Future<int> getUnreadAll();
  Future<int> getUnreadById(int id);
  Future<void> setAsReadAll();
  Future<void> setAsReadByID(int id);
}
