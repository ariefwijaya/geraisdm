part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationStartSuccess extends NotificationState {}

class NotificationStartFailure extends NotificationState {
  final Object error;
  final StackTrace stackTrace;
  const NotificationStartFailure(
      {required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class NotificationNavigateScreen extends NotificationState {
  final NotificationNavigationModel data;
  const NotificationNavigateScreen(this.data);

  @override
  List<Object?> get props => [data];
}

class NotificationOpenUrl extends NotificationState {
  final String url;
  const NotificationOpenUrl(this.url);
  @override
  List<Object> get props => [url];
}

class NotificationFailure extends NotificationState {
  final Object error;
  final StackTrace stackTrace;

  const NotificationFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}
