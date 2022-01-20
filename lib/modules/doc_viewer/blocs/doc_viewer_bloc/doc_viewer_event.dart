part of 'doc_viewer_bloc.dart';

abstract class DocViewerEvent extends Equatable {
  const DocViewerEvent();

  @override
  List<Object?> get props => [];
}

class DocViewerFetch extends DocViewerEvent {
  final int id;
  final String? type;
  const DocViewerFetch({required this.id, this.type});

  @override
  List<Object?> get props => [id, type];
}
