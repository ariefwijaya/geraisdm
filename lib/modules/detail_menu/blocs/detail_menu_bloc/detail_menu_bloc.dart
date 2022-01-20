import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/detail_menu/models/detail_menu_model.dart';
import 'package:geraisdm/modules/detail_menu/repositories/detail_menu_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'detail_menu_event.dart';
part 'detail_menu_state.dart';

@injectable
class DetailMenuBloc extends Bloc<DetailMenuEvent, DetailMenuState> {
  final DetailMenuRepositoryInterface detailMenuRepositoryInterface;

  DetailMenuBloc({required this.detailMenuRepositoryInterface})
      : super(DetailMenuInitial()) {
    on<DetailMenuFetch>((event, emit) async {
      try {
        emit(DetailMenuLoading());
        final res = await detailMenuRepositoryInterface.getDetail(event.id);
        emit(DetailMenuSuccess(data: res));
      } catch (e, s) {
        emit(DetailMenuFailure(error: e, stackTrace: s));
      }
    });
  }
}
