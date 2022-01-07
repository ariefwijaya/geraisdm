import '../models/onboarding_config_model.dart';
import '../providers/onboarding_provider_interface.dart';
import '../../../utils/services/remote_config_service/remote_config_service_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OnboardingProviderInterface)
class OnboardingProvider implements OnboardingProviderInterface {
  final RemoteConfigServiceInterface remoteConfigService;
  const OnboardingProvider({required this.remoteConfigService});
  @override
  Future<OnboardingConfigModel> getConfig() async {
    final res = await remoteConfigService.getJson("onboarding_screen");
    return OnboardingConfigModel.fromJson(res);
  }
}
