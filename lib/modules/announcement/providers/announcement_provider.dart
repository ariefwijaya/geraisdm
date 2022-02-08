import 'package:geraisdm/constant/api_path.dart';
import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/announcement/models/announcement_model.dart';
import 'package:geraisdm/modules/announcement/providers/announcement_provider_interface.dart';
import 'package:geraisdm/utils/services/rest_api_service/rest_api_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AnnouncementProviderInterface)
class AnnouncementProvider implements AnnouncementProviderInterface {
  final RestApiInterface restApi;
  AnnouncementProvider({required this.restApi});
  @override
  Future<List<AnnouncementModel>> getAnnouncement(
      {PaginationControlModel? filter}) async {
    final res = await restApi.get(ApiPath.announcement, body: filter?.toJson());
    return (res.data as List<dynamic>)
        .map((e) => AnnouncementModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<AnnouncementModel> getAnnouncementById(int id) async {
    final res = await restApi.get("${ApiPath.announcement}/$id");
    return AnnouncementModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<void> toggleLiked(int id, {required bool liked}) {
    return restApi
        .post(ApiPath.announcementLiked + "/$id", body: {"liked": liked});
  }
}
