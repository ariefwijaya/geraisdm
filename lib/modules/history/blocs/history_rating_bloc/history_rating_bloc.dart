import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/history/repositories/history_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'history_rating_event.dart';
part 'history_rating_state.dart';

@injectable
class HistoryRatingBloc extends Bloc<HistoryRatingEvent, HistoryRatingState> {
  final HistoryRepositoryInterface historyRepositoryInterface;
  HistoryRatingBloc({required this.historyRepositoryInterface})
      : super(HistoryRatingInitial()) {
    on<HistoryRatingStart>((event, emit) async {
      try {
        emit(HistoryRatingLoading());
        await historyRepositoryInterface.submitReview(event.id, event.value);
        emit(HistoryRatingSuccess(value: event.value));
      } catch (e, s) {
        emit(HistoryRatingFailure(error: e, stackTrace: s));
      }
    });
  }
}
