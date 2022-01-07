import 'package:geraisdm/modules/onboarding/models/onboarding_config_model.dart';
import 'package:geraisdm/modules/onboarding/providers/onboarding_provider_interface.dart';
import 'package:geraisdm/modules/onboarding/repositories/onboarding_repository_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OnboardingRepositoryInterface)
class OnboardingRepository implements OnboardingRepositoryInterface {
  final OnboardingProviderInterface onboardingProvider;
  const OnboardingRepository({required this.onboardingProvider});
  @override
  Future<OnboardingConfigModel> getConfig() {
    return onboardingProvider.getConfig();
  }
}
