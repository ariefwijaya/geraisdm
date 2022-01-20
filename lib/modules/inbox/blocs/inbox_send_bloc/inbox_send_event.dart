part of 'inbox_send_bloc.dart';

abstract class InboxSendEvent extends Equatable {
  const InboxSendEvent();

  @override
  List<Object> get props => [];
}

class InboxSendMessageStart extends InboxSendEvent {
  final int id;
  final String message;

  const InboxSendMessageStart({required this.id, required this.message});

  @override
  List<Object> get props => [id, message];
}
