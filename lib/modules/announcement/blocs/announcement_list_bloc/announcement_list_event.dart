part of 'announcement_list_bloc.dart';

abstract class AnnouncementListEvent extends Equatable {
  const AnnouncementListEvent();

  @override
  List<Object> get props => [];
}

class AnnouncementListFetch extends AnnouncementListEvent {
  final int pageKey;
  const AnnouncementListFetch(this.pageKey);

  @override
  List<Object> get props => [pageKey];
}

class AnnouncementListStarted extends AnnouncementListEvent {}

class AnnouncementRefresh extends AnnouncementListEvent {}
