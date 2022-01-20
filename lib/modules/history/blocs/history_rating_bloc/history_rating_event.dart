part of 'history_rating_bloc.dart';

abstract class HistoryRatingEvent extends Equatable {
  const HistoryRatingEvent();

  @override
  List<Object> get props => [];
}

class HistoryRatingStart extends HistoryRatingEvent {
  final int id;
  final double value;
  const HistoryRatingStart({required this.value, required this.id});

  @override
  List<Object> get props => [value, id];
}
