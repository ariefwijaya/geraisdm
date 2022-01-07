part of 'onboarding_config_bloc.dart';

abstract class OnboardingConfigEvent extends Equatable {
  const OnboardingConfigEvent();

  @override
  List<Object> get props => [];
}

class OnboardingConfigFetch extends OnboardingConfigEvent {}
