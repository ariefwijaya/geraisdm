import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/constant/error_codes.dart';
import 'package:geraisdm/core/settings/models/api_error_model.dart';
import 'package:geraisdm/modules/forgot_password/models/forgot_password_model.dart';
import 'package:geraisdm/modules/forgot_password/repositories/forgot_password_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

@injectable
class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordRepositoryInterface forgotPasswordRepositoryInterface;

  ForgotPasswordBloc({required this.forgotPasswordRepositoryInterface})
      : super(ForgotPasswordInitial()) {
    on<ForgotPasswordStart>((event, emit) async {
      try {
        emit(ForgotPasswordLoading());
        final res = await forgotPasswordRepositoryInterface
            .requestResetPassword(event.username);
        emit(ForgotPasswordSuccess(data: res));
      } on ApiErrorModel catch (e, s) {
        if (e == BackendErrors.forgotPasswordUserNotValid) {
          emit(ForgotPasswordUserNotValid());
        } else {
          emit(ForgotPasswordFailure(error: e, stackTrace: s));
        }
      } catch (e, s) {
        emit(ForgotPasswordFailure(error: e, stackTrace: s));
      }
    });
  }
}
