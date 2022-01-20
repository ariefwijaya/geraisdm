import 'package:geraisdm/core/settings/models/common_model.dart';
import 'package:geraisdm/modules/announcement/models/announcement_model.dart';

abstract class AnnouncementProviderInterface {
  Future<List<AnnouncementModel>> getAnnouncement(
      {PaginationControlModel? filter});

  Future<AnnouncementModel> getAnnouncementById(int id);
  Future<void> toggleLiked(int id, {required bool liked});
}
