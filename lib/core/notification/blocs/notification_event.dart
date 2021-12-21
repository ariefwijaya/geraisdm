part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class NotificationStarted extends NotificationEvent {}

/// Event to start navigate screen or do another actions
class NotificationNavigateTo extends NotificationEvent {
  final NotificationPayloadModel model;
  const NotificationNavigateTo(this.model);

  @override
  List<Object> get props => [model];
}

class NotificationEmitData extends NotificationEvent {
  final NotificationPayloadModel model;
  const NotificationEmitData(this.model);

  @override
  List<Object> get props => [model];
}

class NotificationShowNotif extends NotificationEvent {
  final String title;
  final String subtitle;
  final NotificationPayloadModel? data;
  const NotificationShowNotif(
      {required this.title, required this.subtitle, this.data});

  @override
  List<Object?> get props => [title, subtitle, data];
}
