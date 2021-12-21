import 'dart:convert';

import '../../../core/notification/models/notification_payload_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

/// Class that access [FirebaseMessaging] API
@injectable
class FirebaseNotificationProvider {
  final FirebaseMessaging firebaseCloudMessaging;

  FirebaseNotificationProvider(this.firebaseCloudMessaging);

  /// request notification permission and return the [NotificationSettings]
  Future<NotificationSettings> requestPermission() {
    return firebaseCloudMessaging.requestPermission(
        announcement: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true);
  }

  /// Setup FirebaseMessaging for the first time when app opened.
  ///
  /// [onBackgroundMessage] - Handle notification when running in background.
  /// This should be a top-level function to run expectedly.
  ///
  /// [onMessageOpened] - Process FCM notification messages after clicked by user
  ///
  /// [onForegroundMessage] - Process FCM notification messages after received when app running in foreground.
  /// This should show local notification because Firebase Messaging will not show them when in foreground
  Future<void> setupConfiguration(
      {Future<void> Function(RemoteMessage)? onBackgroundMessage,
      Future<void> Function(RemoteMessage)? onMessageOpened,
      Future<void> Function(RemoteMessage)? onForegroundMessage}) async {
    // Setup options for iOS notifications
    await firebaseCloudMessaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    // Set listener handler for notification that received
    // when app is closed and running in background
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage!);

    // Set listener handler for clicked notification
    FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpened);

    // Set listener handler for notification that received
    // when app is running in foreground
    FirebaseMessaging.onMessage.listen(onForegroundMessage);

    // Get all notifications which not used
    final message = await firebaseCloudMessaging.getInitialMessage();
    if (message != null) {
      onMessageOpened?.call(message);
    }
  }

  NotificationPayloadModel mapStringToNotificationModel(String data) {
    final Map<String, dynamic> json = jsonDecode(data) as Map<String, dynamic>;
    return NotificationPayloadModel.fromJson(json);
  }
}
