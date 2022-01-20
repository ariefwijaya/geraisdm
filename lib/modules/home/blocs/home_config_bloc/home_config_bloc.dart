import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/home/models/home_config_model.dart';
import 'package:geraisdm/modules/home/repositories/home_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'home_config_event.dart';
part 'home_config_state.dart';

@injectable
class HomeConfigBloc extends Bloc<HomeConfigEvent, HomeConfigState> {
  final HomeRepositoryInterface homeRepositoryInterface;
  HomeConfigBloc({required this.homeRepositoryInterface})
      : super(HomeConfigInitial()) {
    on<HomeConfigEvent>((event, emit) async {
      try {
        emit(HomeConfigLoading());
        final resData = await homeRepositoryInterface.getConfig();
        emit(HomeConfigSuccess(resData));
      } catch (e, s) {
        emit(HomeConfigFailure(e, s));
      }
    });
  }
}
