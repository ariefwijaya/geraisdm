part of 'announcement_list_bloc.dart';

abstract class AnnouncementListState extends Equatable {
  const AnnouncementListState();

  @override
  List<Object> get props => [];
}

class AnnouncementListInitial extends AnnouncementListState {}

class AnnouncementListStartSuccess extends AnnouncementListState {
  final PagingController<int, AnnouncementModel> pagingController;
  const AnnouncementListStartSuccess(this.pagingController);

  @override
  List<Object> get props => [pagingController];
}

class AnnouncementListFailure extends AnnouncementListState {
  final Object error;
  final StackTrace stackTrace;

  const AnnouncementListFailure(
      {required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}
