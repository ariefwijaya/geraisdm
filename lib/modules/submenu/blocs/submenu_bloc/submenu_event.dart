part of 'submenu_bloc.dart';

abstract class SubmenuEvent extends Equatable {
  const SubmenuEvent();

  @override
  List<Object> get props => [];
}

class SubmenuFetch extends SubmenuEvent {
  final int id;
  const SubmenuFetch({required this.id});

  @override
  List<Object> get props => [id];
}
