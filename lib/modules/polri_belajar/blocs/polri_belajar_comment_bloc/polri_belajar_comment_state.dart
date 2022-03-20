part of 'polri_belajar_comment_bloc.dart';

abstract class PolriBelajarCommentState extends Equatable {
  const PolriBelajarCommentState();

  @override
  List<Object> get props => [];
}

class PolriBelajarCommentInitial extends PolriBelajarCommentState {}

class PolriBelajarCommentFailure extends PolriBelajarCommentState {
  final Object error;
  final StackTrace stackTrace;

  const PolriBelajarCommentFailure(
      {required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class PolriBelajarCommentLoading extends PolriBelajarCommentState {}

class PolriBelajarCommentSuccess extends PolriBelajarCommentState {
  final List<PolriBelajarCommentModel> data;

  const PolriBelajarCommentSuccess({required this.data});

  @override
  List<Object> get props => [data];
}
