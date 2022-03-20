import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/polri_belajar/models/polri_belajar_comment_model.dart';
import 'package:geraisdm/modules/polri_belajar/repositories/polri_belajar_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'polri_belajar_comment_event.dart';
part 'polri_belajar_comment_state.dart';

@injectable
class PolriBelajarCommentBloc
    extends Bloc<PolriBelajarCommentEvent, PolriBelajarCommentState> {
  final PolriBelajarRepositoryInterface polriBelajarRepositoryInterface;
  PolriBelajarCommentBloc({required this.polriBelajarRepositoryInterface})
      : super(PolriBelajarCommentInitial()) {
    on<PolriBelajarCommentFetch>((event, emit) async {
      try {
        emit(PolriBelajarCommentLoading());
        final res = await polriBelajarRepositoryInterface.getComments(
            event.id, event.refId);
        emit(PolriBelajarCommentSuccess(data: res));
      } catch (e, s) {
        emit(PolriBelajarCommentFailure(error: e, stackTrace: s));
      }
    });
  }
}
