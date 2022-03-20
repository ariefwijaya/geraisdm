part of 'polri_belajar_list_bloc.dart';

abstract class PolriBelajarListEvent extends Equatable {
  const PolriBelajarListEvent();

  @override
  List<Object> get props => [];
}

class PolriBelajarListFetch extends PolriBelajarListEvent {
  final int pageKey;
  const PolriBelajarListFetch(this.pageKey);

  @override
  List<Object> get props => [pageKey];
}

class PolriBelajarListStarted extends PolriBelajarListEvent {
  final int refId;
  const PolriBelajarListStarted(this.refId);

  @override
  List<Object> get props => [refId];
}

class PolriBelajarRefresh extends PolriBelajarListEvent {}
