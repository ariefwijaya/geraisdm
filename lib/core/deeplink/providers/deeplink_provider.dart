import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:geraisdm/core/deeplink/models/deeplink_config_model.dart';
import 'package:geraisdm/utils/services/remote_config_service/remote_config_service_interface.dart';
import 'package:injectable/injectable.dart';

import 'deeplink_provider_interface.dart';

@Injectable(as: DeeplinkProviderInterface)
class DeeplinkProvider implements DeeplinkProviderInterface {
  final FirebaseDynamicLinks dynamicLinks;
  final RemoteConfigServiceInterface remoteConfigService;

  const DeeplinkProvider(
      {required this.dynamicLinks, required this.remoteConfigService});

  Future<DeeplinkConfigModel> _getConfig() async {
    final res = await remoteConfigService.getJson("dynamic_link");
    return DeeplinkConfigModel.fromJson(res);
  }

  Future<DynamicLinkParameters> _getParams(String url) async {
    final config = await _getConfig();

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      // The Dynamic Link URI domain. You can view created URIs on your Firebase console
      uriPrefix: config.uriPrefix,
      // The deep Link passed to your application which you can use to affect change
      link: Uri.parse(url),
      // Android application details needed for opening correct app on device/Play Store
      androidParameters: AndroidParameters(
        packageName: config.androidPackageName,
        minimumVersion: config.androidMinimumVersion,
      ),
      // iOS application details needed for opening correct app on device/App Store
      iosParameters: IOSParameters(
        bundleId: config.iosBundleId,
        minimumVersion: config.iosMinimumVersion,
      ),
    );

    return parameters;
  }

  @override
  Future<String?> getInitialLink() async {
    final res = await dynamicLinks.getInitialLink();
    if (res != null) {
      String path = res.link.path;
      if (res.link.hasQuery) {
        path = path + "?" + res.link.query;
      }

      if (path.isNotEmpty) {
        return path;
      }
    }
    return null;
  }

  @override
  Future<String> getLink(String url) async {
    final params = await _getParams(url);
    final Uri uri = await dynamicLinks.buildLink(params);
    return uri.path;
  }

  @override
  Future<String> getShortLink(String url) async {
    final params = await _getParams(url);
    final res = await dynamicLinks.buildShortLink(params);
    return res.shortUrl.path;
  }

  @override
  Stream<PendingDynamicLinkData> onLinkStream() {
    return dynamicLinks.onLink;
  }
}
