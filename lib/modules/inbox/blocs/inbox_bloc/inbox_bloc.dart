import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/inbox/models/inbox_detail_model.dart';
import 'package:geraisdm/modules/inbox/repositories/inbox_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'inbox_event.dart';
part 'inbox_state.dart';

@injectable
class InboxBloc extends Bloc<InboxEvent, InboxState> {
  final InboxRepositoryInterface inboxRepositoryInterface;
  InboxBloc({required this.inboxRepositoryInterface}) : super(InboxInitial()) {
    on<InboxFetchDetail>((event, emit) async {
      try {
        emit(InboxLoading());
        final res = await inboxRepositoryInterface.getInboxById(event.id);
        emit(InboxSuccess(data: res));
      } catch (e, s) {
        emit(InboxFailure(error: e, stackTrace: s));
      }
    });
  }
}
