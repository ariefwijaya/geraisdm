import 'package:geraisdm/constant/api_path.dart';
import 'package:geraisdm/modules/articles/models/article_model.dart';
import 'package:geraisdm/modules/announcement/models/announcement_model.dart';
import 'package:geraisdm/modules/home/models/home_config_model.dart';
import 'package:geraisdm/modules/home/models/home_menu_model.dart';
import 'package:geraisdm/modules/home/providers/home_provider_interface.dart';
import 'package:geraisdm/utils/services/remote_config_service/remote_config_service_interface.dart';
import 'package:geraisdm/utils/services/rest_api_service/rest_api_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeProviderInterface)
class HomeProvider implements HomeProviderInterface {
  final RemoteConfigServiceInterface remoteConfigService;
  final RestApiInterface restApiService;

  const HomeProvider(
      {required this.remoteConfigService, required this.restApiService});
  @override
  Future<HomeConfigModel> getConfig() async {
    final res = await remoteConfigService.getJson("home_screen");
    return HomeConfigModel.fromJson(res);
  }

  @override
  Future<List<HomeMenuModel>> getAdditionalMenu() async {
    final res = await restApiService.get(ApiPath.menusAdditional);
    return (res.data as List<dynamic>)
        .map((e) => HomeMenuModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<AnnouncementModel>> getLatestAnnouncements() async {
    final res = await restApiService.get(ApiPath.announcementLatest);
    return (res.data as List<dynamic>)
        .map((e) => AnnouncementModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<ArticleModel>> getLatestArticles() async {
    final res = await restApiService.get(ApiPath.articlesLatest);
    return (res.data as List<dynamic>)
        .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<HomeMenuModel>> getMainMenu() async {
    final res = await restApiService.get(ApiPath.menus);
    return (res.data as List<dynamic>)
        .map((e) => HomeMenuModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
