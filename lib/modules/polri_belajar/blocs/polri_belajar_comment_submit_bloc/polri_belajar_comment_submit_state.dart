part of 'polri_belajar_comment_submit_bloc.dart';

abstract class PolriBelajarCommentSubmitState extends Equatable {
  const PolriBelajarCommentSubmitState();

  @override
  List<Object> get props => [];
}

class PolriBelajarCommentSubmitInitial extends PolriBelajarCommentSubmitState {}

class PolriBelajarCommentSubmitLoading extends PolriBelajarCommentSubmitState {}

class PolriBelajarCommentSubmitFailure extends PolriBelajarCommentSubmitState {
  final Object error;
  final StackTrace stackTrace;

  const PolriBelajarCommentSubmitFailure(
      {required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class PolriBelajarCommentSubmitSuccess extends PolriBelajarCommentSubmitState {
  final PolriBelajarCommentModel data;

  const PolriBelajarCommentSubmitSuccess({required this.data});

  @override
  List<Object> get props => [data];
}
