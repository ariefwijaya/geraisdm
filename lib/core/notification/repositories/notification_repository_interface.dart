import '../../../core/notification/models/notification_payload_model.dart';
import 'package:geraisdm/core/notification/models/notification_payload_model.dart';

abstract class NotificationRepositoryInterface {
  Future<void> initNotification();
  Future<void> showNotification(
      {required int id,
      required String title,
      required String body,
      NotificationPayloadModel? data});
}
