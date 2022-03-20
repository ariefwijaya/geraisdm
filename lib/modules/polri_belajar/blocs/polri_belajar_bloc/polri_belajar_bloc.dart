import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/polri_belajar/models/polri_belajar_model.dart';
import 'package:geraisdm/modules/polri_belajar/repositories/polri_belajar_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'polri_belajar_event.dart';
part 'polri_belajar_state.dart';

@injectable
class PolriBelajarBloc extends Bloc<PolriBelajarEvent, PolriBelajarState> {
  final PolriBelajarRepositoryInterface polriBelajarRepository;

  PolriBelajarBloc({required this.polriBelajarRepository})
      : super(PolriBelajarInitial()) {
    on<PolriBelajarFetchDetail>((event, emit) async {
      try {
        emit(PolriBelajarLoading());
        final res = await polriBelajarRepository.getPolriBelajarById(
            event.id, event.refId);
        emit(PolriBelajarDetailSuccess(data: res));
      } catch (e, s) {
        emit(PolriBelajarFailure(error: e, stackTrace: s));
      }
    });
  }
}
