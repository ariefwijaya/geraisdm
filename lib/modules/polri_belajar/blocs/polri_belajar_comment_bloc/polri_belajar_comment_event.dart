part of 'polri_belajar_comment_bloc.dart';

abstract class PolriBelajarCommentEvent extends Equatable {
  const PolriBelajarCommentEvent();

  @override
  List<Object> get props => [];
}

class PolriBelajarCommentFetch extends PolriBelajarCommentEvent {
  final int id;
  final int refId;
  const PolriBelajarCommentFetch({required this.id, required this.refId});
  @override
  List<Object> get props => [id, refId];
}
