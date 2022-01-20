part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final String name;
  final String? avatarUrl;

  const HomeSuccess({required this.name, required this.avatarUrl});

  @override
  List<Object?> get props => [name, avatarUrl];
}

class HomeFailure extends HomeState {
  final Object error;
  final StackTrace trace;
  const HomeFailure(this.error, this.trace);

  @override
  List<Object> get props => [error, trace];
}
