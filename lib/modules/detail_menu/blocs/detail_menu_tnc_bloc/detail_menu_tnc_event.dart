part of 'detail_menu_tnc_bloc.dart';

abstract class DetailMenuTncEvent extends Equatable {
  const DetailMenuTncEvent();

  @override
  List<Object> get props => [];
}

class DetailMenuTncFetch extends DetailMenuTncEvent {
  final int id;

  const DetailMenuTncFetch({required this.id});

  @override
  List<Object> get props => [id];
}
