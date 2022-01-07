import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:geraisdm/core/deeplink/providers/deeplink_provider_interface.dart';
import 'package:injectable/injectable.dart';

import 'deeplink_repository_interface.dart';

@Injectable(as: DeeplinkRepositoryInterface)
class DeeplinkRepository implements DeeplinkRepositoryInterface {
  final DeeplinkProviderInterface deeplinkProvider;
  const DeeplinkRepository({required this.deeplinkProvider});

  @override
  Future<String?> getInitialLink() {
    return deeplinkProvider.getInitialLink();
  }

  @override
  Future<String> getLink(String url) {
    return deeplinkProvider.getLink(url);
  }

  @override
  Future<String> getShortLink(String url) {
    return deeplinkProvider.getShortLink(url);
  }

  @override
  Stream<PendingDynamicLinkData> onLinkStream() {
    return deeplinkProvider.onLinkStream();
  }
}
