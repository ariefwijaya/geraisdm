part of 'submenu_bloc.dart';

abstract class SubmenuState extends Equatable {
  const SubmenuState();

  @override
  List<Object> get props => [];
}

class SubmenuInitial extends SubmenuState {}

class SubmenuLoading extends SubmenuState {}

class SubmenuFailure extends SubmenuState {
  final Object error;
  final StackTrace stackTrace;

  const SubmenuFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class SubmenuSuccess extends SubmenuState {
  final List<SubmenuModel> listData;

  const SubmenuSuccess({required this.listData});
  @override
  List<Object> get props => [listData];
}
