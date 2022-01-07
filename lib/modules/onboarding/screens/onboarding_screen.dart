import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/widgets/button_component.dart';
import '../../../widgets/common_placeholder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import '../../../config/injectable/injectable_core.dart';
import '../blocs/onboarding_config_bloc/onboarding_config_bloc.dart';
import 'components/onboarding_content.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            getIt.get<OnboardingConfigBloc>()..add(OnboardingConfigFetch()),
        child: BlocBuilder<OnboardingConfigBloc, OnboardingConfigState>(
          builder: (context, state) {
            if (state is OnboardingConfigSuccess) {
              return OnboardingContent(
                  enabledSkip: state.config.enabledSkip,
                  contents: state.config.content);
            }

            if (state is OnboardingConfigFailure) {
              return CommonPlaceholder.error(
                  title: LocaleKeys.onboarding_config_failed_title.tr(),
                  subtitle: LocaleKeys.onboarding_config_failed_subtitle.tr(),
                  action: FilledButton.large(
                      buttonText:
                          LocaleKeys.onboarding_config_failed_retry.tr(),
                      onPressed: () => context
                          .read<OnboardingConfigBloc>()
                          .add(OnboardingConfigFetch())));
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
