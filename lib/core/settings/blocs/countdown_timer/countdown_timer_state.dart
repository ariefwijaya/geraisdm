part of 'countdown_timer_cubit.dart';

class CountdownTimerState extends Equatable {
  final int seconds;
  const CountdownTimerState(this.seconds);

  String get durationFormat {
    return Duration(seconds: seconds).toString().substring(2, 7);
  }

  @override
  List<Object> get props => [seconds];
}
