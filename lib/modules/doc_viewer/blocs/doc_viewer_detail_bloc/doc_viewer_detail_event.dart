part of 'doc_viewer_detail_bloc.dart';

abstract class DocViewerDetailEvent extends Equatable {
  const DocViewerDetailEvent();

  @override
  List<Object?> get props => [];
}

class DocViewerDetailFetch extends DocViewerDetailEvent {
  final int id;
  final String? type;

  const DocViewerDetailFetch({required this.id, this.type});
  @override
  List<Object?> get props => [id, type];
}
