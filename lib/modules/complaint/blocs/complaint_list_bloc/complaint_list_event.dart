part of 'complaint_list_bloc.dart';

abstract class ComplaintListEvent extends Equatable {
  const ComplaintListEvent();

  @override
  List<Object> get props => [];
}

class ComplaintListFetch extends ComplaintListEvent {
  final int pageKey;
  const ComplaintListFetch(this.pageKey);

  @override
  List<Object> get props => [pageKey];
}

class ComplaintListStarted extends ComplaintListEvent {}

class ComplaintRefresh extends ComplaintListEvent {}
