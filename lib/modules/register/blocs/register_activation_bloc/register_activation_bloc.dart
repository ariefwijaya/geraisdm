import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/constant/error_codes.dart';
import 'package:geraisdm/core/settings/models/api_error_model.dart';
import 'package:geraisdm/modules/register/models/register_form_model.dart';
import 'package:geraisdm/modules/register/repositories/register_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'register_activation_event.dart';
part 'register_activation_state.dart';

@injectable
class RegisterActivationBloc
    extends Bloc<RegisterActivationEvent, RegisterActivationState> {
  final RegisterRepositoryInterface registerRepository;

  RegisterActivationBloc({required this.registerRepository})
      : super(RegisterActivationInitial()) {
    on<RegisterActivationStart>((event, emit) async {
      try {
        emit(RegisterActivationLoading());
        await registerRepository.register(otp: event.otp, data: event.data);
        emit(RegisterActivationSuccess());
      } on ApiErrorModel catch (e, s) {
        if (e == BackendErrors.registerActivationWrongOTP) {
          emit(RegisterActivationOTPWrong());
        } else if (e == BackendErrors.registerActivationExpiredOTP) {
          emit(RegisterActivationOTPExpired());
        } else if (e == BackendErrors.registerActivationBadRequest) {
          emit(RegisterActivationBadRequest());
        } else if (e == BackendErrors.registerActivationWrongBirthday) {
          emit(RegisterActivationBirthdayWrong());
        } else {
          emit(RegisterActivationFailure(error: e, stackTrace: s));
        }
      } catch (e, s) {
        emit(RegisterActivationFailure(error: e, stackTrace: s));
      }
    });
  }
}
