part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryFailure extends HistoryState {
  final Object error;
  final StackTrace stackTrace;

  const HistoryFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class HistorySuccess extends HistoryState {
  final HistoryDetailModel data;

  const HistorySuccess({required this.data});

  @override
  List<Object> get props => [data];
}
