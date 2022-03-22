import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/core/auth/repositories/auth_repository_interface.dart';
import 'package:geraisdm/modules/polri_belajar/models/polri_belajar_comment_model.dart';
import 'package:geraisdm/modules/polri_belajar/repositories/polri_belajar_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'polri_belajar_comment_submit_event.dart';
part 'polri_belajar_comment_submit_state.dart';

@injectable
class PolriBelajarCommentSubmitBloc extends Bloc<PolriBelajarCommentSubmitEvent,
    PolriBelajarCommentSubmitState> {
  final PolriBelajarRepositoryInterface polriBelajarRepositoryInterface;
  final AuthRepositoryInterface authRepositoryInterface;
  PolriBelajarCommentSubmitBloc(
      {required this.polriBelajarRepositoryInterface,
      required this.authRepositoryInterface})
      : super(PolriBelajarCommentSubmitInitial()) {
    on<PolriBelajarCommentSubmit>((event, emit) async {
      try {
        emit(PolriBelajarCommentSubmitLoading());
        final userData = await authRepositoryInterface.getUserData();
        await polriBelajarRepositoryInterface.addComment(
            event.id, event.refId, event.comment);
        emit(PolriBelajarCommentSubmitSuccess(
            data: PolriBelajarCommentModel(
                userName: userData.fullName,
                comment: event.comment,
                avatar: userData.avatar,
                date: DateTime.now())));
      } catch (e, s) {
        emit(PolriBelajarCommentSubmitFailure(error: e, stackTrace: s));
      }
    });
  }
}
