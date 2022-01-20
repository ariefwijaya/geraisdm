part of 'announcement_like_bloc.dart';

abstract class AnnouncementLikeEvent extends Equatable {
  const AnnouncementLikeEvent();

  @override
  List<Object> get props => [];
}

class AnnouncementLikeStart extends AnnouncementLikeEvent {
  final int id;
  final bool like;
  const AnnouncementLikeStart({required this.id, required this.like});

  @override
  List<Object> get props => [id, like];
}
