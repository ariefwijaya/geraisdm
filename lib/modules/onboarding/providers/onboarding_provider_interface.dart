import '../models/onboarding_config_model.dart';

abstract class OnboardingProviderInterface {
  Future<OnboardingConfigModel> getConfig();
}
