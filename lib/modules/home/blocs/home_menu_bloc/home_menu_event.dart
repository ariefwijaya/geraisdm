part of 'home_menu_bloc.dart';

abstract class HomeMenuEvent extends Equatable {
  const HomeMenuEvent();

  @override
  List<Object> get props => [];
}

class HomeMenuFetch extends HomeMenuEvent {}
