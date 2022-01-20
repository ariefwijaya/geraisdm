part of 'history_rating_bloc.dart';

abstract class HistoryRatingState extends Equatable {
  const HistoryRatingState();

  @override
  List<Object> get props => [];
}

class HistoryRatingInitial extends HistoryRatingState {}

class HistoryRatingLoading extends HistoryRatingState {}

class HistoryRatingFailure extends HistoryRatingState {
  final Object error;
  final StackTrace stackTrace;

  const HistoryRatingFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class HistoryRatingSuccess extends HistoryRatingState {
  final double value;
  const HistoryRatingSuccess({required this.value});

  @override
  List<Object> get props => [value];
}
