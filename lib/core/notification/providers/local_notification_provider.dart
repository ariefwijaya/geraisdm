import 'dart:convert';

import '../../../constant/app_constant.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:timezone/timezone.dart';

@injectable
class LocalNotificationProvider {
  LocalNotificationProvider(this._flutterLocalNotificationsPlugin);

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  /// GroupId for channel notifications,
  /// so notifications will be grouped in the notification bar
  final String _groupId = "com.sintechsolution.geraisdm";

  /// List of available notification channels
  List<AndroidNotificationChannel> channels = [];

  Future<void> setupConfiguration(
      {Future<dynamic> Function(int, String?, String?, String?)?
          onDidReceiveLocalNotification,
      Future<dynamic> Function(String?)? onSelectNotification}) async {
    // Declare channel List before initialized
    channels = [
      const AndroidNotificationChannel(
          'high_importance_channel', // id
          'Default', // title
          description:
              'This channel is used for default notifications.', // description
          importance: Importance.max,
          sound: RawResourceAndroidNotificationSound(
              AppConstant.notificationSound),
          enableLights: true)
    ];

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings(AppConstant.notificationIcon);

    final IOSInitializationSettings iosSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    // Remove Registered Notification Channels before replace them using the new one
    for (final AndroidNotificationChannel channel_ in channels) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.deleteNotificationChannel(channel_.id);
    }

    // Register notification channels
    for (final AndroidNotificationChannel channel_ in channels) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel_);
    }
  }

  /// Create and Show local notification
  Future<void> showNotification(
      {required int id,
      required String title,
      required String body,
      required bool playSound,
      String? data}) async {
    if (channels.isEmpty) {
      return;
    } else {
      return _flutterLocalNotificationsPlugin.show(
          id,
          title,
          body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                  channels[0].id, channels[0].name,
                  channelDescription: channels[0].description,
                  importance: Importance.max,
                  priority: Priority.high,
                  visibility: NotificationVisibility.public,
                  groupKey: _groupId,
                  icon: AppConstant.notificationIcon,
                  playSound: playSound),
              iOS: IOSNotificationDetails(
                  threadIdentifier: _groupId, presentSound: playSound)),
          payload: data);
    }
  }

  Future<void> scheduledNotification(
      int id, String? title, String? body, TZDateTime scheduledDate,
      {String? payload}) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        scheduledDate,
        NotificationDetails(
            android: AndroidNotificationDetails(
                channels[0].id, channels[0].name,
                channelDescription: channels[0].description,
                importance: Importance.max,
                priority: Priority.high,
                visibility: NotificationVisibility.public,
                groupKey: _groupId,
                icon: AppConstant.notificationIcon),
            iOS: IOSNotificationDetails(threadIdentifier: _groupId)),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        payload: payload != null ? jsonEncode(payload) : null);
  }

  Future<void> periodicNotification(
      int id, String? title, String? body, RepeatInterval repeatInterval,
      {String? payload}) async {
    await _flutterLocalNotificationsPlugin.periodicallyShow(
        id,
        title,
        body,
        repeatInterval,
        NotificationDetails(
            android: AndroidNotificationDetails(
                channels[0].id, channels[0].name,
                channelDescription: channels[0].description,
                importance: Importance.max,
                priority: Priority.high,
                visibility: NotificationVisibility.public,
                groupKey: _groupId,
                icon: AppConstant.notificationIcon),
            iOS: IOSNotificationDetails(threadIdentifier: _groupId)),
        androidAllowWhileIdle: true,
        payload: payload != null ? jsonEncode(payload) : null);
  }
}
