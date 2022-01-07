part of 'onboarding_config_bloc.dart';

abstract class OnboardingConfigState extends Equatable {
  const OnboardingConfigState();

  @override
  List<Object> get props => [];
}

class OnboardingConfigInitial extends OnboardingConfigState {}

class OnboardingConfigLoading extends OnboardingConfigState {}

class OnboardingConfigFailure extends OnboardingConfigState {
  final Object error;
  final StackTrace stackTrace;

  const OnboardingConfigFailure(
      {required this.error, required this.stackTrace});

  @override
  List<Object> get props => [error, stackTrace];
}

class OnboardingConfigSuccess extends OnboardingConfigState {
  final OnboardingConfigModel config;

  const OnboardingConfigSuccess({required this.config});

  @override
  List<Object> get props => [config];
}
