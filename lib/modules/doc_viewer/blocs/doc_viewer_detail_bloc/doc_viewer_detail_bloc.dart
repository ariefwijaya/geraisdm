import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/doc_viewer/models/doc_viewer_detail_model.dart';
import 'package:geraisdm/modules/doc_viewer/repositories/doc_viewer_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'doc_viewer_detail_event.dart';
part 'doc_viewer_detail_state.dart';

@injectable
class DocViewerDetailBloc
    extends Bloc<DocViewerDetailEvent, DocViewerDetailState> {
  final DocViewerRepositoryInterface docViewerRepositoryInterface;
  DocViewerDetailBloc({required this.docViewerRepositoryInterface})
      : super(DocViewerDetailInitial()) {
    on<DocViewerDetailFetch>((event, emit) async {
      try {
        emit(DocViewerDetailLoading());
        final res =
            await docViewerRepositoryInterface.getDetail(event.id, event.type);
        emit(DocViewerDetailSuccess(data: res));
      } catch (e, s) {
        emit(DocViewerDetailFailure(error: e, stackTrace: s));
      }
    });
  }
}
