part of 'announcement_bloc.dart';

abstract class AnnouncementEvent extends Equatable {
  const AnnouncementEvent();

  @override
  List<Object> get props => [];
}

class AnnouncementFetchDetail extends AnnouncementEvent {
  final int id;
  const AnnouncementFetchDetail({required this.id});

  @override
  List<Object> get props => [id];
}
