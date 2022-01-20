part of 'announcement_bloc.dart';

abstract class AnnouncementState extends Equatable {
  const AnnouncementState();

  @override
  List<Object> get props => [];
}

class AnnouncementInitial extends AnnouncementState {}

class AnnouncementLoading extends AnnouncementState {}

class AnnouncementDetailSuccess extends AnnouncementState {
  final AnnouncementModel data;
  const AnnouncementDetailSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class AnnouncementFailure extends AnnouncementState {
  final Object error;
  final StackTrace stackTrace;

  const AnnouncementFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class WalkthroughLoading extends AnnouncementState {}

class WalkthroughFailure extends AnnouncementState {
  final Object error;
  final StackTrace stackTrace;

  const WalkthroughFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}
