import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'countdown_timer_state.dart';

@injectable
class CountdownTimerCubit extends Cubit<CountdownTimerState> {
  CountdownTimerCubit() : super(const CountdownTimerState(0));

  Timer? _timer;

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  ///[start] is the remaining seconds to be countdown
  void startTimer({required int start}) {
    int _start = start;
    emit(CountdownTimerState(_start));
    const oneSec = Duration(seconds: 1);
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start < 1) {
          timer.cancel();
        } else {
          _start = _start - 1;
        }

        emit(CountdownTimerState(_start));
      },
    );
  }

  void stopTimer() {
    _timer?.cancel();
  }
}
