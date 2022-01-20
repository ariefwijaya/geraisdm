part of 'home_menu_bloc.dart';

abstract class HomeMenuState extends Equatable {
  const HomeMenuState();

  @override
  List<Object> get props => [];
}

class HomeMenuInitial extends HomeMenuState {}

class HomeMenuLoading extends HomeMenuState {}

class HomeMenuFailure extends HomeMenuState {
  final Object error;
  final StackTrace stackTrace;

  const HomeMenuFailure({required this.error, required this.stackTrace});
  @override
  List<Object> get props => [error, stackTrace];
}

class HomeMenuListSuccess extends HomeMenuState {
  final List<HomeMenuModel> listData;
  const HomeMenuListSuccess({required this.listData});

  @override
  List<Object> get props => [listData];
}
