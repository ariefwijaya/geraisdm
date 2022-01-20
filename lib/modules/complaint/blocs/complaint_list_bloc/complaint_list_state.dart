part of 'complaint_list_bloc.dart';

abstract class ComplaintListState extends Equatable {
  const ComplaintListState();

  @override
  List<Object> get props => [];
}

class ComplaintListInitial extends ComplaintListState {}

class ComplaintListStartSuccess extends ComplaintListState {
  final PagingController<int, ComplaintModel> pagingController;
  const ComplaintListStartSuccess(this.pagingController);

  @override
  List<Object> get props => [pagingController];
}

class ComplaintListFailure extends ComplaintListState {
  final Object error;
  final StackTrace stackTrace;

  const ComplaintListFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}
