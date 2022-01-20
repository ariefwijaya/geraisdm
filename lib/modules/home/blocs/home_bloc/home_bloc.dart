import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/core/auth/repositories/auth_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthRepositoryInterface authRepositoryInterface;
  HomeBloc({required this.authRepositoryInterface}) : super(HomeInitial()) {
    on<HomeFetchHeader>((event, emit) async {
      try {
        emit(HomeLoading());
        final res = await authRepositoryInterface.getUserData();
        emit(HomeSuccess(name: res.fullName, avatarUrl: res.avatar));
      } catch (e, s) {
        emit(HomeFailure(e, s));
      }
    });
  }
}
