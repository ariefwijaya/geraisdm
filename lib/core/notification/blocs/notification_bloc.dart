import '../../../core/notification/models/notification_navigation_model.dart';
import '../../../core/notification/models/notification_payload_model.dart';
import '../../../core/notification/repositories/notification_repository_interface.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'notification_event.dart';
part 'notification_state.dart';

//BLoc to manage Notification between firebase and local notification
@lazySingleton
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepositoryInterface _notificationRepository;

  NotificationBloc(this._notificationRepository)
      : super(NotificationInitial()) {
    on<NotificationStarted>((event, emit) async {
      try {
        await _notificationRepository.initNotification();
        emit(NotificationStartSuccess());
      } catch (e, s) {
        emit(NotificationStartFailure(error: e, stackTrace: s));
      }
    });

    on<NotificationNavigateTo>((event, emit) async {
      try {
        final payload = event.model;
        if (payload.actionType == ActionType.url) {
          emit(NotificationOpenUrl(payload.params));
        } else if (payload.actionType == ActionType.screen) {
          final paramsDecoded =
              NotificationNavigationModel.fromString(payload.params);
          emit(NotificationNavigateScreen(paramsDecoded));
        }
      } catch (e, s) {
        emit(NotificationFailure(error: e, stackTrace: s));
      }
    });

    on<NotificationEmitData>((event, emit) async {
      try {
        emit(NotificationLoading());
        // final payload = event.model;
        //state to open custom in app dialog based on push notif
      } catch (e, s) {
        emit(NotificationFailure(error: e, stackTrace: s));
      }
    });

    on<NotificationShowNotif>((event, emit) async {
      try {
        await _notificationRepository.showNotification(
            id: event.hashCode,
            title: event.title,
            body: event.subtitle,
            data: event.data);
      } catch (e, s) {
        emit(NotificationFailure(error: e, stackTrace: s));
      }
    });
  }
}
