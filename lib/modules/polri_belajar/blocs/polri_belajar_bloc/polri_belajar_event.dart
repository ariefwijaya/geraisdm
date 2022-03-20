part of 'polri_belajar_bloc.dart';

abstract class PolriBelajarEvent extends Equatable {
  const PolriBelajarEvent();

  @override
  List<Object> get props => [];
}

class PolriBelajarFetchDetail extends PolriBelajarEvent {
  final int id;
  final int refId;
  const PolriBelajarFetchDetail({required this.id, required this.refId});

  @override
  List<Object> get props => [id, refId];
}
