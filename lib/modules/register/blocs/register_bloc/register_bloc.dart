import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/constant/error_codes.dart';
import 'package:geraisdm/core/settings/models/api_error_model.dart';
import 'package:geraisdm/modules/register/repositories/register_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'register_event.dart';
part 'register_state.dart';

@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepositoryInterface registerRepository;
  RegisterBloc({required this.registerRepository}) : super(RegisterInitial()) {
    on<RegisterRequestOTP>((event, emit) async {
      try {
        emit(RegisterLoading());
        final res = await registerRepository.requestVerification(
            type: event.type,
            username: event.username,
            handphone: event.handphone);
        emit(RegisterSuccess(expiry: res.expiry, otpLength: res.otpLength));
      } on ApiErrorModel catch (e, s) {
        if (e == BackendErrors.registerUserAlreadyRegistered) {
          emit(RegisterAlreadyRegistered());
        } else if (e == BackendErrors.registerPhoneUsed) {
          emit(RegisterPhoneHasBeenUsed());
        } else if (e == BackendErrors.registerInvalidNRP) {
          emit(RegisterNRPInvalid());
        } else if (e == BackendErrors.registerInvalidNIK) {
          emit(RegisterNIKInvalid());
        } else {
          emit(RegisterFailure(error: e, stackTrace: s));
        }
      } catch (e, s) {
        emit(RegisterFailure(error: e, stackTrace: s));
      }
    });
  }
}
