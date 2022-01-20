import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/doc_viewer/models/doc_viewer_model.dart';
import 'package:geraisdm/modules/doc_viewer/repositories/doc_viewer_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'doc_viewer_event.dart';
part 'doc_viewer_state.dart';

@injectable
class DocViewerBloc extends Bloc<DocViewerEvent, DocViewerState> {
  final DocViewerRepositoryInterface docViewerRepositoryInterface;
  DocViewerBloc({required this.docViewerRepositoryInterface})
      : super(DocViewerInitial()) {
    on<DocViewerFetch>((event, emit) async {
      try {
        emit(DocViewerLoading());
        final res =
            await docViewerRepositoryInterface.getList(event.id, event.type);
        emit(DocViewerSuccess(data: res));
      } catch (e, s) {
        emit(DocViewerFailure(error: e, stackTrace: s));
      }
    });
  }
}
