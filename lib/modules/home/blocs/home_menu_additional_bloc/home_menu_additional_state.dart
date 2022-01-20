part of 'home_menu_additional_bloc.dart';

abstract class HomeMenuAdditionalState extends Equatable {
  const HomeMenuAdditionalState();

  @override
  List<Object> get props => [];
}

class HomeMenuAdditionalInitial extends HomeMenuAdditionalState {}

class HomeMenuAdditionalLoading extends HomeMenuAdditionalState {}

class HomeMenuAdditionalFailure extends HomeMenuAdditionalState {
  final Object error;
  final StackTrace stackTrace;

  const HomeMenuAdditionalFailure(
      {required this.error, required this.stackTrace});
  @override
  List<Object> get props => [error, stackTrace];
}

class HomeMenuAdditionalListSuccess extends HomeMenuAdditionalState {
  final List<HomeMenuModel> listData;
  const HomeMenuAdditionalListSuccess({required this.listData});

  @override
  List<Object> get props => [listData];
}
