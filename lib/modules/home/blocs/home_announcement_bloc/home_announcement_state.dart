part of 'home_announcement_bloc.dart';

abstract class HomeAnnouncementState extends Equatable {
  const HomeAnnouncementState();

  @override
  List<Object> get props => [];
}

class HomeAnnouncementInitial extends HomeAnnouncementState {}

class HomeAnnouncementLoading extends HomeAnnouncementState {}

class HomeAnnouncementFailure extends HomeAnnouncementState {
  final Object error;
  final StackTrace stackTrace;

  const HomeAnnouncementFailure(
      {required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class HomeAnnouncementSuccess extends HomeAnnouncementState {
  final List<AnnouncementModel> listData;
  const HomeAnnouncementSuccess({required this.listData});

  @override
  List<Object> get props => [listData];
}
