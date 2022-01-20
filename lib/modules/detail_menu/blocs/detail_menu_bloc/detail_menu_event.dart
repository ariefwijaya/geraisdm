part of 'detail_menu_bloc.dart';

abstract class DetailMenuEvent extends Equatable {
  const DetailMenuEvent();

  @override
  List<Object> get props => [];
}

class DetailMenuFetch extends DetailMenuEvent {
  final int id;
  const DetailMenuFetch({required this.id});

  @override
  List<Object> get props => [id];
}
