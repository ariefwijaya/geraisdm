part of 'home_layout_config_bloc.dart';

abstract class HomeLayoutConfigEvent extends Equatable {
  const HomeLayoutConfigEvent();

  @override
  List<Object> get props => [];
}

class HomeLayoutConfigFetch extends HomeLayoutConfigEvent {}
