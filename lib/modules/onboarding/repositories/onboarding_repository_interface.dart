import '../models/onboarding_config_model.dart';

abstract class OnboardingRepositoryInterface {
  Future<OnboardingConfigModel> getConfig();
}
