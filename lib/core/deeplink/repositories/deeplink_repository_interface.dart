import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

abstract class DeeplinkRepositoryInterface {
  Future<String> getLink(String url);
  Future<String> getShortLink(String url);
  Future<String?> getInitialLink();
  Stream<PendingDynamicLinkData> onLinkStream();
}
