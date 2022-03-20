import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/polri_belajar/repositories/polri_belajar_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'polri_belajar_comment_submit_event.dart';
part 'polri_belajar_comment_submit_state.dart';

@injectable
class PolriBelajarCommentSubmitBloc extends Bloc<PolriBelajarCommentSubmitEvent,
    PolriBelajarCommentSubmitState> {
  final PolriBelajarRepositoryInterface polriBelajarRepositoryInterface;
  PolriBelajarCommentSubmitBloc({required this.polriBelajarRepositoryInterface})
      : super(PolriBelajarCommentSubmitInitial()) {
    on<PolriBelajarCommentSubmit>((event, emit) async {
      try {
        emit(PolriBelajarCommentSubmitLoading());
        await polriBelajarRepositoryInterface.addComment(
            event.id, event.refId, event.comment);
        emit(PolriBelajarCommentSubmitSuccess());
      } catch (e, s) {
        emit(PolriBelajarCommentSubmitFailure(error: e, stackTrace: s));
      }
    });
  }
}
