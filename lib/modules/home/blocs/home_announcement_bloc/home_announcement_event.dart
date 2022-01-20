part of 'home_announcement_bloc.dart';

abstract class HomeAnnouncementEvent extends Equatable {
  const HomeAnnouncementEvent();

  @override
  List<Object> get props => [];
}

class HomeAnnouncementFetch extends HomeAnnouncementEvent {}
