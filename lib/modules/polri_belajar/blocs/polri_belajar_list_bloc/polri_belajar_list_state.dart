part of 'polri_belajar_list_bloc.dart';

abstract class PolriBelajarListState extends Equatable {
  const PolriBelajarListState();

  @override
  List<Object> get props => [];
}

class PolriBelajarListInitial extends PolriBelajarListState {}

class PolriBelajarListStartSuccess extends PolriBelajarListState {
  final PagingController<int, PolriBelajarModel> pagingController;
  const PolriBelajarListStartSuccess(this.pagingController);

  @override
  List<Object> get props => [pagingController];
}

class PolriBelajarListFailure extends PolriBelajarListState {
  final Object error;
  final StackTrace stackTrace;

  const PolriBelajarListFailure(
      {required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}
