import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/login/models/login_config_model.dart';
import 'package:geraisdm/modules/login/repositories/login_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'login_config_event.dart';
part 'login_config_state.dart';

@injectable
class LoginConfigBloc extends Bloc<LoginConfigEvent, LoginConfigState> {
  final LoginRepositoryInterface loginRepository;

  LoginConfigBloc({required this.loginRepository})
      : super(LoginConfigInitial()) {
    on<LoginConfigFetch>((event, emit) async {
      try {
        emit(LoginConfigLoading());
        final res = await loginRepository.getConfig();
        emit(LoginConfigSuccess(config: res));
      } catch (e, s) {
        emit(LoginConfigFailure(error: e, stackTrace: s));
      }
    });
  }
}
