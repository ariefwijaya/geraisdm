part of 'inbox_bloc.dart';

abstract class InboxEvent extends Equatable {
  const InboxEvent();

  @override
  List<Object> get props => [];
}

class InboxFetchDetail extends InboxEvent {
  final int id;
  const InboxFetchDetail({required this.id});
  @override
  List<Object> get props => [id];
}
