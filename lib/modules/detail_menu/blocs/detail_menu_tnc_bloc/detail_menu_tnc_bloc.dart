import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/detail_menu/models/detail_menu_tnc_model.dart';
import 'package:geraisdm/modules/detail_menu/repositories/detail_menu_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'detail_menu_tnc_event.dart';
part 'detail_menu_tnc_state.dart';

@injectable
class DetailMenuTncBloc extends Bloc<DetailMenuTncEvent, DetailMenuTncState> {
  final DetailMenuRepositoryInterface detailMenuRepositoryInterface;
  DetailMenuTncBloc({required this.detailMenuRepositoryInterface})
      : super(DetailMenuTncInitial()) {
    on<DetailMenuTncFetch>((event, emit) async {
      try {
        emit(DetailMenuTncLoading());
        final res = await detailMenuRepositoryInterface.getTNC(event.id);
        emit(DetailMenuTncSuccess(data: res));
      } catch (e, s) {
        emit(DetailMenuTncFailure(error: e, stackTrace: s));
      }
    });
  }
}
