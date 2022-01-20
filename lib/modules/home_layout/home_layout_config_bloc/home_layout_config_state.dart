part of 'home_layout_config_bloc.dart';

abstract class HomeLayoutConfigState extends Equatable {
  const HomeLayoutConfigState();

  @override
  List<Object> get props => [];
}

class HomeLayoutConfigInitial extends HomeLayoutConfigState {}

class HomeLayoutConfigLoading extends HomeLayoutConfigState {}

class HomeLayoutConfigSuccess extends HomeLayoutConfigState {
  final LayoutConfigModel config;
  const HomeLayoutConfigSuccess({required this.config});

  @override
  List<Object> get props => [config];
}

class HomeLayoutConfigFailure extends HomeLayoutConfigState {
  final Object error;
  final StackTrace trace;
  const HomeLayoutConfigFailure(this.error, this.trace);

  @override
  List<Object> get props => [error, trace];
}
