part of 'detail_menu_tnc_bloc.dart';

abstract class DetailMenuTncState extends Equatable {
  const DetailMenuTncState();

  @override
  List<Object> get props => [];
}

class DetailMenuTncInitial extends DetailMenuTncState {}

class DetailMenuTncLoading extends DetailMenuTncState {}

class DetailMenuTncFailure extends DetailMenuTncState {
  final Object error;
  final StackTrace stackTrace;

  const DetailMenuTncFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class DetailMenuTncSuccess extends DetailMenuTncState {
  final DetailMenuTNCModel data;

  const DetailMenuTncSuccess({required this.data});

  @override
  List<Object> get props => [data];
}
