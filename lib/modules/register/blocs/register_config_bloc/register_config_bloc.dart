import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/register/models/register_config_model.dart';
import 'package:geraisdm/modules/register/repositories/register_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'register_config_event.dart';
part 'register_config_state.dart';

@injectable
class RegisterConfigBloc
    extends Bloc<RegisterConfigEvent, RegisterConfigState> {
  final RegisterRepositoryInterface registerRepository;

  RegisterConfigBloc({required this.registerRepository})
      : super(RegisterConfigInitial()) {
    on<RegisterConfigFetch>((event, emit) async {
      try {
        emit(RegisterConfigLoading());
        final res = await registerRepository.getConfig();
        emit(RegisterConfigSuccess(config: res));
      } catch (e, s) {
        emit(RegisterConfigFailure(error: e, stackTrace: s));
      }
    });
  }
}
