part of 'home_config_bloc.dart';

abstract class HomeConfigEvent extends Equatable {
  const HomeConfigEvent();

  @override
  List<Object> get props => [];
}

class HomeConfigFetch extends HomeConfigEvent {}
