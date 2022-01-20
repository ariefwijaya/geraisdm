import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/home_layout/models/layout_config_model.dart';
import 'package:geraisdm/modules/home_layout/repositories/home_layout_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'home_layout_config_event.dart';
part 'home_layout_config_state.dart';

@injectable
class HomeLayoutConfigBloc
    extends Bloc<HomeLayoutConfigEvent, HomeLayoutConfigState> {
  final HomeLayoutRepositoryInterface homeLayoutRepository;
  HomeLayoutConfigBloc({required this.homeLayoutRepository})
      : super(HomeLayoutConfigInitial()) {
    on<HomeLayoutConfigFetch>((event, emit) async {
      try {
        emit(HomeLayoutConfigLoading());
        final res = await homeLayoutRepository.getHomeLayoutConfig();
        emit(HomeLayoutConfigSuccess(config: res));
      } catch (e, s) {
        emit(HomeLayoutConfigFailure(e, s));
      }
    });
  }
}
