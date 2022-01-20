part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class HistoryFetchDetail extends HistoryEvent {
  final int id;
  const HistoryFetchDetail({required this.id});
  @override
  List<Object> get props => [id];
}
