part of 'detail_menu_bloc.dart';

abstract class DetailMenuState extends Equatable {
  const DetailMenuState();

  @override
  List<Object> get props => [];
}

class DetailMenuInitial extends DetailMenuState {}

class DetailMenuLoading extends DetailMenuState {}

class DetailMenuFailure extends DetailMenuState {
  final Object error;
  final StackTrace stackTrace;

  const DetailMenuFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class DetailMenuSuccess extends DetailMenuState {
  final DetailMenuModel data;

  const DetailMenuSuccess({required this.data});

  @override
  List<Object> get props => [data];
}
