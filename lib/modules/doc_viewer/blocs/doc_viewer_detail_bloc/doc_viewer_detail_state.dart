part of 'doc_viewer_detail_bloc.dart';

abstract class DocViewerDetailState extends Equatable {
  const DocViewerDetailState();

  @override
  List<Object> get props => [];
}

class DocViewerDetailInitial extends DocViewerDetailState {}

class DocViewerDetailLoading extends DocViewerDetailState {}

class DocViewerDetailFailure extends DocViewerDetailState {
  final Object error;
  final StackTrace stackTrace;

  const DocViewerDetailFailure({required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class DocViewerDetailSuccess extends DocViewerDetailState {
  final DocViewerDetailModel data;

  const DocViewerDetailSuccess({required this.data});

  @override
  List<Object> get props => [data];
}
