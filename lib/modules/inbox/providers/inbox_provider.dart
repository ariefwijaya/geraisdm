import 'package:geraisdm/constant/api_path.dart';
import 'package:geraisdm/modules/inbox/models/inbox_model.dart';
import 'package:geraisdm/modules/inbox/models/inbox_detail_model.dart';
import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/inbox/providers/inbox_provider_interface.dart';
import 'package:geraisdm/utils/services/rest_api_service/rest_api_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: InboxProviderInterface)
class InboxProvider implements InboxProviderInterface {
  final RestApiInterface restApiInterface;
  const InboxProvider({required this.restApiInterface});
  @override
  Future<List<InboxModel>> getInbox({PaginationControlModel? filter}) async {
    final res =
        await restApiInterface.get(ApiPath.inbox, body: filter?.toJson());
    return (res.data as List<dynamic>)
        .map((e) => InboxModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<InboxDetailModel>> getInboxById(int id) async {
    final res = await restApiInterface.get("${ApiPath.inbox}/$id");
    return (res.data as List<dynamic>)
        .map((e) => InboxDetailModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> sendMessage(int id, String message) {
    return restApiInterface.post(ApiPath.sendMessage,
        body: {"id_activity": id, "message": message});
  }

  @override
  Future<int> getUnreadAll() async {
    final res = await restApiInterface.get(ApiPath.inboxUnread);
    return res.data['unread_total'] as int;
  }

  @override
  Future<void> setAsReadAll() {
    return restApiInterface.post(ApiPath.inboxMarkRead);
  }

  @override
  Future<void> setAsReadByID(int id) {
    return restApiInterface.post(ApiPath.inboxMarkRead + "/$id");
  }

  @override
  Future<int> getUnreadById(int id) async {
    final res = await restApiInterface.get(ApiPath.inboxUnread + "/$id");
    return res.data['unread_total'] as int;
  }
}
