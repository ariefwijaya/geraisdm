import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/home/models/home_menu_model.dart';
import 'package:geraisdm/modules/home/repositories/home_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'home_menu_event.dart';
part 'home_menu_state.dart';

@injectable
class HomeMenuBloc extends Bloc<HomeMenuEvent, HomeMenuState> {
  final HomeRepositoryInterface homeRepositoryInterface;
  HomeMenuBloc({required this.homeRepositoryInterface})
      : super(HomeMenuInitial()) {
    on<HomeMenuFetch>((event, emit) async {
      try {
        emit(HomeMenuLoading());
        final res = await homeRepositoryInterface.getMainMenu();
        emit(HomeMenuListSuccess(listData: res));
      } catch (e, s) {
        emit(HomeMenuFailure(error: e, stackTrace: s));
      }
    });
  }
}
