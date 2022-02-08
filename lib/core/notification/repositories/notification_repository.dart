import 'package:alice/alice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geraisdm/core/auth/providers/auth_local_provider_interface.dart';
import 'package:geraisdm/core/notification/providers/firebase_notification_provider.dart';
import 'package:geraisdm/utils/services/local_storage_service/local_storage_service.dart';
import '../../../core/notification/models/notification_payload_model.dart';
import '../../../core/notification/providers/local_notification_provider.dart';
import '../../../config/injectable/injectable_core.dart';
import '../../../core/notification/blocs/notification_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:drift/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

import 'notification_repository_interface.dart';

final NotificationBloc notificationBloc = getIt.get<NotificationBloc>();

Future<dynamic> firebaseMessagingBackgroundHandler(
    RemoteMessage message) async {
  try {
    //Should be called whenever we need to use another firebase services
    await Firebase.initializeApp();

    //Remote config
    if (message.data["CONFIG_STATE"] != null) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setBool("CONFIG_STALE", true);
    } else {
      NotificationPayloadModel? payload;
      if (message.data["action_type"] != null) {
        payload = NotificationPayloadModel.fromJson(message.data);
        await _processForegroundBackgroundCallback(payload);
      }

      final bool showForeground = payload?.showForeground ?? true;
      final bool playSound = payload?.playSound ?? true;

      if (showForeground &&
          (UniversalPlatform.isIOS || UniversalPlatform.isMacOS)) {
        //required by ios
        final LocalNotificationProvider localNotificationProvider =
            LocalNotificationProvider(FlutterLocalNotificationsPlugin());
        await localNotificationProvider.setupConfiguration(
            onSelectNotification: processClickedLocalNotification);
        await localNotificationProvider.showNotification(
            id: message.notification.hashCode,
            title: message.notification!.title!,
            body: message.notification!.body!,
            data: payload?.toStringify(),
            playSound: playSound);
      }
    }
  } catch (e, s) {
    FirebaseCrashlytics.instance.recordError(e, s);
  }
}

Future<void> processClickedLocalNotification(String? payload) async {
  // Don't do anything when payload is null
  if (payload == null) return;
  try {
    final NotificationPayloadModel notifModel =
        NotificationPayloadModel.fromString(payload);
    await processNotificationPayload(notifModel);
  } catch (e, s) {
    FirebaseCrashlytics.instance.recordError(e, s);
  }
}

Future<dynamic> processNotificationPayload(
    NotificationPayloadModel payload) async {
  notificationBloc.add(NotificationNavigateTo(payload));
}

Future<void> _processForegroundBackgroundCallback(
    NotificationPayloadModel payload) async {}

@Injectable(as: NotificationRepositoryInterface)
class NotificationRepository implements NotificationRepositoryInterface {
  final FirebaseNotificationProvider fcmProvider;
  final LocalNotificationProvider localNotificationProvider;
  final SharedPreferences sharedPreferences;
  final AuthLocalProviderInterface authLocalProvider;

  NotificationRepository(
      {required this.fcmProvider,
      required this.localNotificationProvider,
      required this.sharedPreferences,
      required this.authLocalProvider});

  @override
  Future<void> initNotification() async {
    await fcmProvider.requestPermission();
    await localNotificationProvider.setupConfiguration(
        onSelectNotification: _processClickedLocalNotification);

    await fcmProvider.setupConfiguration(
        onBackgroundMessage: firebaseMessagingBackgroundHandler,
        onMessageOpened: _processClickedFirebaseNotification,
        onForegroundMessage: _processForegroundFirebaseNotification);

    //Refresh Device Token
    fcmProvider.firebaseCloudMessaging.onTokenRefresh.listen((token) async {
      try {
        final session = await authLocalProvider.getActiveSession();
        if (session != null) {
          await authLocalProvider
              .updateSession(SessionsCompanion(deviceToken: Value(token)));
        }
      } catch (e, s) {
        FirebaseCrashlytics.instance.recordError(e, s);
      }
    });
  }

  Future<void> _processForegroundFirebaseNotification(
      RemoteMessage remoteMessage) async {
    try {
      NotificationPayloadModel? payload;
      if (remoteMessage.data.isNotEmpty) {
        //Remote config
        if (remoteMessage.data["CONFIG_STATE"] != null) {
          await sharedPreferences.setBool("CONFIG_STALE", true);
        } else {
          if (remoteMessage.data["action_type"] != null) {
            payload = NotificationPayloadModel.fromJson(remoteMessage.data);
            await _processForegroundBackgroundCallback(payload);
            notificationBloc.add(NotificationEmitData(payload));
          }
          final bool showForeground = payload?.showForeground ?? true;
          final bool playSound = payload?.playSound ?? true;

          if (showForeground) {
            await localNotificationProvider.showNotification(
                id: remoteMessage.notification.hashCode,
                title: remoteMessage.notification!.title!,
                body: remoteMessage.notification!.body!,
                data: payload?.toStringify(),
                playSound: playSound);
          }
        }
      }
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  Future<void> _processClickedLocalNotification(String? payload) async {
    // Don't do anything when payload is null
    if (payload == null) return;
    try {
      if (payload == "") {
        getIt.get<Alice>().showInspector();
      } else {
        final NotificationPayloadModel notifModel =
            NotificationPayloadModel.fromString(payload);
        await _processNotificationPayload(notifModel);
      }
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  Future<void> _processClickedFirebaseNotification(
      RemoteMessage? remoteMessage) async {
    if (remoteMessage?.data == null) return;
    try {
      final NotificationPayloadModel notifModel =
          NotificationPayloadModel.fromJson(remoteMessage!.data);
      await _processNotificationPayload(notifModel);
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  Future<dynamic> _processNotificationPayload(
      NotificationPayloadModel payload) async {
    notificationBloc.add(NotificationNavigateTo(payload));
  }

  @override
  Future<void> showNotification(
      {required int id,
      required String title,
      required String body,
      NotificationPayloadModel? data}) {
    return localNotificationProvider.showNotification(
        id: id,
        title: title,
        body: body,
        playSound: true,
        data: data?.toStringify());
  }
}
