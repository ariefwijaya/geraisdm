import '../../../../core/auth/models/auth_model.dart';
import '../../../../core/auth/repositories/auth_repository_interface.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@singleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryInterface authRepository;

  AuthBloc({required this.authRepository}) : super(AuthUninitalized()) {
    on<AuthStartedEv>((event, emit) async {
      try {
        emit(AuthLoading());
        final currentSession = await authRepository.getLoggedinSession();
        if (currentSession != null) {
          emit(AuthAuthenticated(session: currentSession));
        } else {
          emit(AuthUnauthenticated());
        }
      } catch (e, s) {
        emit(AuthFailure(e, s));
      }
    });

    on<AuthLogoutEv>((event, emit) async {
      try {
        emit(AuthLoading());
        await authRepository.logoutSession();
        emit(AuthUnauthenticated());
      } catch (e) {
        // yield AuthFailure(e, s);
        emit(AuthUnauthenticated());
      }
    });
    on<AuthShowExpired>((event, emit) async {
      try {
        if (await authRepository.isLoggedIn()) {
          emit(AuthExpired());
        }
      } catch (e, s) {
        emit(AuthFailure(e, s));
      }
    });
  }
}
