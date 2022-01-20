part of 'home_config_bloc.dart';

abstract class HomeConfigState extends Equatable {
  const HomeConfigState();

  @override
  List<Object> get props => [];
}

class HomeConfigInitial extends HomeConfigState {}

class HomeConfigLoading extends HomeConfigState {}

class HomeConfigSuccess extends HomeConfigState {
  final HomeConfigModel data;
  const HomeConfigSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class HomeConfigFailure extends HomeConfigState {
  final Object error;
  final StackTrace stackTrace;
  const HomeConfigFailure(this.error, this.stackTrace);

  @override
  List<Object> get props => [error, stackTrace];
}
