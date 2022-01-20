import 'package:geraisdm/modules/articles/models/article_model.dart';
import 'package:geraisdm/modules/announcement/models/announcement_model.dart';
import 'package:geraisdm/modules/home/models/home_config_model.dart';
import 'package:geraisdm/modules/home/models/home_menu_model.dart';
import 'package:geraisdm/modules/home/providers/home_provider_interface.dart';
import 'package:geraisdm/modules/home/repositories/home_repository_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepositoryInterface)
class HomeRepository implements HomeRepositoryInterface {
  final HomeProviderInterface homeProviderInterface;
  const HomeRepository({required this.homeProviderInterface});
  @override
  Future<HomeConfigModel> getConfig() {
    return homeProviderInterface.getConfig();
  }

  @override
  Future<List<HomeMenuModel>> getAdditionalMenu() {
    return homeProviderInterface.getAdditionalMenu();
  }

  @override
  Future<List<AnnouncementModel>> getLatestAnnouncements() {
    return homeProviderInterface.getLatestAnnouncements();
  }

  @override
  Future<List<ArticleModel>> getLatestArticles() {
    return homeProviderInterface.getLatestArticles();
  }

  @override
  Future<List<HomeMenuModel>> getMainMenu() {
    return homeProviderInterface.getMainMenu();
  }
}
