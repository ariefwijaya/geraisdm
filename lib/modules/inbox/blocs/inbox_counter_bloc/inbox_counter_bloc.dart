import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/inbox/repositories/inbox_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'inbox_counter_event.dart';
part 'inbox_counter_state.dart';

@injectable
class InboxCounterBloc extends Bloc<InboxCounterEvent, InboxCounterState> {
  final InboxRepositoryInterface inboxRepositoryInterface;
  InboxCounterBloc({required this.inboxRepositoryInterface})
      : super(InboxCounterInitial()) {
    on<InboxCounterSetAsReadStart>((event, emit) async {
      try {
        if (event.id != null) {
          await inboxRepositoryInterface.setAsReadByID(event.id!);
        } else {
          await inboxRepositoryInterface.setAsReadAll();
        }
        emit(const InboxCounterUnreadTotal(total: 0));
      } catch (e, s) {
        emit(InboxCounterFailure(error: e, stackTrace: s));
      }
    });

    on<InboxCounterUnreadFetch>((event, emit) async {
      try {
        if (event.id != null) {
          final res = await inboxRepositoryInterface.getUnreadById(event.id!);
          emit(InboxCounterUnreadTotal(total: res));
        } else {
          final res = await inboxRepositoryInterface.getUnreadAll();
          emit(InboxCounterUnreadTotal(total: res));
        }
      } catch (e, s) {
        emit(InboxCounterFailure(error: e, stackTrace: s));
      }
    });
  }
}
