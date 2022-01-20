import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/history/models/history_detail_model.dart';
import 'package:geraisdm/modules/history/repositories/history_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'history_event.dart';
part 'history_state.dart';

@injectable
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepositoryInterface historyRepositoryInterface;
  HistoryBloc({required this.historyRepositoryInterface})
      : super(HistoryInitial()) {
    on<HistoryFetchDetail>((event, emit) async {
      try {
        emit(HistoryLoading());
        final res = await historyRepositoryInterface.getHistoryById(event.id);
        emit(HistorySuccess(data: res));
      } catch (e, s) {
        emit(HistoryFailure(error: e, stackTrace: s));
      }
    });
  }
}
