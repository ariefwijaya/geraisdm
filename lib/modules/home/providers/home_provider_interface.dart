import 'package:geraisdm/modules/announcement/models/announcement_model.dart';
import 'package:geraisdm/modules/articles/models/article_model.dart';
import 'package:geraisdm/modules/home/models/home_config_model.dart';
import 'package:geraisdm/modules/home/models/home_menu_model.dart';

abstract class HomeProviderInterface {
  Future<HomeConfigModel> getConfig();
  Future<List<ArticleModel>> getLatestArticles();
  Future<List<AnnouncementModel>> getLatestAnnouncements();
  Future<List<HomeMenuModel>> getMainMenu();
  Future<List<HomeMenuModel>> getAdditionalMenu();
}
