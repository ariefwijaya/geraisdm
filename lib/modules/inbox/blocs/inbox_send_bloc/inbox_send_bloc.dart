import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/inbox/repositories/inbox_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'inbox_send_event.dart';
part 'inbox_send_state.dart';

@injectable
class InboxSendBloc extends Bloc<InboxSendEvent, InboxSendState> {
  final InboxRepositoryInterface inboxRepositoryInterface;
  InboxSendBloc({required this.inboxRepositoryInterface})
      : super(InboxSendInitial()) {
    on<InboxSendMessageStart>((event, emit) async {
      try {
        emit(InboxSendLoading());
        await inboxRepositoryInterface.sendMessage(event.id, event.message);
        emit(InboxSendSuccess(message: event.message));
      } catch (e, s) {
        emit(InboxSendFailure(error: e, stackTrace: s));
      }
    });
  }
}
