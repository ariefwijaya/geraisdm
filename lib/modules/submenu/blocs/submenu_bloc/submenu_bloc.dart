import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/submenu/models/submenu_model.dart';
import 'package:geraisdm/modules/submenu/repositories/submenu_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'submenu_event.dart';
part 'submenu_state.dart';

@injectable
class SubmenuBloc extends Bloc<SubmenuEvent, SubmenuState> {
  final SubmenuRepositoryInterface submenuRepositoryInterface;

  SubmenuBloc({required this.submenuRepositoryInterface})
      : super(SubmenuInitial()) {
    on<SubmenuFetch>((event, emit) async {
      try {
        emit(SubmenuLoading());
        final res = await submenuRepositoryInterface.getSubmenus(event.id);
        emit(SubmenuSuccess(listData: res));
      } catch (e, s) {
        emit(SubmenuFailure(error: e, stackTrace: s));
      }
    });
  }
}
