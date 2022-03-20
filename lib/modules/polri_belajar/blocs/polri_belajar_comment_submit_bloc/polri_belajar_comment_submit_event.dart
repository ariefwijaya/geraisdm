part of 'polri_belajar_comment_submit_bloc.dart';

abstract class PolriBelajarCommentSubmitEvent extends Equatable {
  const PolriBelajarCommentSubmitEvent();

  @override
  List<Object> get props => [];
}

class PolriBelajarCommentSubmit extends PolriBelajarCommentSubmitEvent {
  final int id;
  final int refId;
  final String comment;
  const PolriBelajarCommentSubmit(
      {required this.id, required this.refId, required this.comment});
  @override
  List<Object> get props => [id, refId, comment];
}
