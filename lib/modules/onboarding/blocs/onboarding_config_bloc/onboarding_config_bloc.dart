import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geraisdm/modules/onboarding/models/onboarding_config_model.dart';
import 'package:geraisdm/modules/onboarding/repositories/onboarding_repository_interface.dart';
import 'package:injectable/injectable.dart';

part 'onboarding_config_event.dart';
part 'onboarding_config_state.dart';

@injectable
class OnboardingConfigBloc
    extends Bloc<OnboardingConfigEvent, OnboardingConfigState> {
  final OnboardingRepositoryInterface onboardingRepository;

  OnboardingConfigBloc({required this.onboardingRepository})
      : super(OnboardingConfigInitial()) {
    on<OnboardingConfigFetch>((event, emit) async {
      try {
        emit(OnboardingConfigLoading());
        final res = await onboardingRepository.getConfig();
        emit(OnboardingConfigSuccess(config: res));
      } catch (e, s) {
        emit(OnboardingConfigFailure(error: e, stackTrace: s));
      }
    });
  }
}
