part of 'doc_viewer_bloc.dart';

abstract class DocViewerState extends Equatable {
  const DocViewerState();

  @override
  List<Object> get props => [];
}

class DocViewerInitial extends DocViewerState {}

class DocViewerLoading extends DocViewerState {}

class DocViewerFailure extends DocViewerState {
  final Object error;
  final StackTrace stackTrace;

  const DocViewerFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class DocViewerSuccess extends DocViewerState {
  final List<DocViewerModel> data;

  const DocViewerSuccess({required this.data});

  @override
  List<Object> get props => [data];
}
