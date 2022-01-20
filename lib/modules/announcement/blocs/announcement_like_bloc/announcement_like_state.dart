part of 'announcement_like_bloc.dart';

abstract class AnnouncementLikeState extends Equatable {
  const AnnouncementLikeState();

  @override
  List<Object> get props => [];
}

class AnnouncementLikeInitial extends AnnouncementLikeState {}

class AnnouncementLikeLoading extends AnnouncementLikeState {}

class AnnouncementLikeFailure extends AnnouncementLikeState {
  final Object error;
  final StackTrace stackTrace;

  const AnnouncementLikeFailure(
      {required this.error, required this.stackTrace});
  @override
  List<Object> get props => [error, stackTrace];
}

class AnnouncementLikeSuccess extends AnnouncementLikeState {
  final bool liked;
  const AnnouncementLikeSuccess({required this.liked});
  @override
  List<Object> get props => [liked];
}
