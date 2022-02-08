import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/constant/error_codes.dart';
import 'package:geraisdm/core/settings/models/api_error_model.dart';
import 'package:geraisdm/modules/forgot_password/models/forgot_password_form_model.dart';
import 'package:geraisdm/modules/forgot_password/repositories/forgot_password_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'forgot_password_confirm_event.dart';
part 'forgot_password_confirm_state.dart';

@injectable
class ForgotPasswordConfirmBloc
    extends Bloc<ForgotPasswordConfirmEvent, ForgotPasswordConfirmState> {
  final ForgotPasswordRepositoryInterface forgotPasswordRepositoryInterface;
  ForgotPasswordConfirmBloc({required this.forgotPasswordRepositoryInterface})
      : super(ForgotPasswordConfirmInitial()) {
    on<ForgotPasswordConfirmStart>((event, emit) async {
      try {
        emit(ForgotPasswordConfirmLoading());
        await forgotPasswordRepositoryInterface.confirmReset(event.form);
        emit(ForgotPasswordConfirmSuccess());
      } on ApiErrorModel catch (e, s) {
        if (e == BackendErrors.forgotPasswordConfirmWrongOTP) {
          emit(ForgotPasswordConfirmWrongOTP());
        } else if (e == BackendErrors.forgotPasswordConfirmExpiredOTP) {
          emit(ForgotPasswordConfirmExpiredOTP());
        } else {
          emit(ForgotPasswordConfirmFailure(error: e, stackTrace: s));
        }
      } catch (e, s) {
        emit(ForgotPasswordConfirmFailure(error: e, stackTrace: s));
      }
    });
  }
}
