import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../constant/error_codes.dart';
import '../../../../core/auth/repositories/auth_repository_interface.dart';
import '../../../../core/settings/models/api_error_model.dart';
import '../../models/login_form_model.dart';
import '../../repositories/login_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepositoryInterface loginRepository;
  final AuthRepositoryInterface authRepository;

  LoginBloc({required this.loginRepository, required this.authRepository})
      : super(LoginInitial()) {
    on<LoginStart>((event, emit) async {
      try {
        emit(LoginLoading());
        final resLogin = await loginRepository.login(
            LoginFormModel(username: event.username, password: event.password));
        await authRepository.loginSession(resLogin);
        if (resLogin.deviceToken != null) {
          await loginRepository.setDeviceToken(resLogin.deviceToken!);
        }
        emit(LoginSuccess());
      } on ApiErrorModel catch (e, s) {
        if (e == BackendErrors.loginWrongAccess) {
          emit(LoginWrongPassword());
        } else if (e == BackendErrors.loginBadRequest) {
          emit(LoginBadRequest());
        } else if (e == BackendErrors.loginNotRegistered) {
          emit(LoginNotRegistered());
        } else if (e == BackendErrors.loginDuplicatedRequest) {
          emit(LoginDuplicatedRequest());
        } else {
          emit(LoginFailed(error: e, stackTrace: s));
        }
      } catch (e, s) {
        emit(LoginFailed(error: e, stackTrace: s));
      }
    });
  }
}
