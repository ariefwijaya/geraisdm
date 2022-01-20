import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/announcement/models/announcement_model.dart';
import 'package:geraisdm/modules/announcement/providers/announcement_provider_interface.dart';
import 'package:geraisdm/modules/announcement/repositories/announcement_repository_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AnnouncementRepositoryInterface)
class AnnouncementRepository implements AnnouncementRepositoryInterface {
  final AnnouncementProviderInterface announcementProvider;

  const AnnouncementRepository({required this.announcementProvider});
  @override
  Future<List<AnnouncementModel>> getAnnouncement(
      {PaginationControlModel? filter}) async {
    return announcementProvider.getAnnouncement(filter: filter);
  }

  @override
  Future<List<AnnouncementModel>> getHighlight() {
    return announcementProvider.getAnnouncement(
        filter: const PaginationControlModel(pageSize: 6, pageOffset: 0));
  }

  @override
  Future<AnnouncementModel> getAnnouncementById(int id) {
    return announcementProvider.getAnnouncementById(id);
  }

  @override
  Future<void> toggleLiked(int id, {required bool liked}) {
    return announcementProvider.toggleLiked(id, liked: liked);
  }
}
