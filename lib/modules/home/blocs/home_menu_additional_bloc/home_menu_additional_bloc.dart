import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/home/models/home_menu_model.dart';
import 'package:geraisdm/modules/home/repositories/home_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'home_menu_additional_event.dart';
part 'home_menu_additional_state.dart';

@injectable
class HomeMenuAdditionalBloc
    extends Bloc<HomeMenuAdditionalEvent, HomeMenuAdditionalState> {
  final HomeRepositoryInterface homeRepositoryInterface;
  HomeMenuAdditionalBloc({required this.homeRepositoryInterface})
      : super(HomeMenuAdditionalInitial()) {
    on<HomeMenuAdditionalFetch>((event, emit) async {
      try {
        emit(HomeMenuAdditionalLoading());
        final res = await homeRepositoryInterface.getAdditionalMenu();
        emit(HomeMenuAdditionalListSuccess(listData: res));
      } catch (e, s) {
        emit(HomeMenuAdditionalFailure(error: e, stackTrace: s));
      }
    });
  }
}
