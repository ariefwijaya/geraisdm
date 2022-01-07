import '../../config/injectable/injectable_core.dart';
import '../../constant/assets.gen.dart';
import '../../constant/localizations.g.dart';
import '../../core/auth/blocs/auth_bloc.dart';
import '../../core/settings/blocs/app_update_cubit/app_update_cubit.dart';
import '../../widgets/alert_component.dart';
import '../../widgets/button_component.dart';
import '../../widgets/icon_alert_component.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_review/in_app_review.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppUpdateCubit>(
      create: (context) => getIt.get<AppUpdateCubit>()..checkVersion(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<AppUpdateCubit, AppUpdateState>(
              listener: (context, state) {
            if (state is AppUpdateShowed) {
              showUpdateDialog(context,
                      currentVersion: state.currentVersion,
                      newVersion: state.newVersion,
                      forceUpdate: state.force)
                  .then(
                      (value) => context.read<AuthBloc>().add(AuthStartedEv()));
            } else {
              context.read<AuthBloc>().add(AuthStartedEv());
            }
          })
        ],
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthFailure) {
              return _buildFailure(context);
            }
            return _buildSplashScreenContent(state, context);
          },
        ),
      ),
    );
  }

  Widget _buildSplashScreenContent(AuthState state, BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 80),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Assets.images.icon.logo.image(),
              if (state is AuthLoading)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(
                    color: Theme.of(context).primaryColor,
                    backgroundColor: Theme.of(context).highlightColor,
                  ),
                ),
            ],
          )),
    );
  }

  Widget _buildFailure(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => context.read<AuthBloc>().add(AuthLogoutEv()),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ErrorIconPlaceholder(icon: Icons.account_circle),
            const SizedBox(height: 48),
            Text(LocaleKeys.auth_failed_title.tr(),
                style: Theme.of(context).textTheme.headline3),
            const SizedBox(height: 20),
            Text(
              LocaleKeys.auth_failed_subtitle.tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            FilledButton.large(
                buttonText: LocaleKeys.auth_failed_retry.tr(),
                onPressed: () => context.read<AuthBloc>().add(AuthStartedEv()))
          ],
        ),
      ),
    );
  }

  Future<void> showUpdateDialog(BuildContext context,
      {required String currentVersion,
      required String newVersion,
      bool forceUpdate = false}) {
    return showAlertPlaceholder(
        dismissible: !forceUpdate,
        context: context,
        title: LocaleKeys.app_update_title.tr(),
        subtitle: "${LocaleKeys.app_update_subtitle.tr(args: [
              newVersion,
              LocaleKeys.app_name.tr(),
              currentVersion
            ])}\n\n${LocaleKeys.app_update_hint.tr()}",
        action: Row(
          children: [
            if (!forceUpdate)
              Expanded(
                  child: GhostButton.large(
                      buttonText: LocaleKeys.app_update_later.tr(),
                      onPressed: () {
                        context.read<AppUpdateCubit>().skipUpdate();
                        context.popRoute();
                      })),
            const SizedBox(width: 8),
            Expanded(
              child: FilledButton.large(
                  buttonText: LocaleKeys.app_update_download.tr(),
                  onPressed: () {
                    context.popRoute();
                    //TODO: use env or remoteconfig and in bloc instead
                    final InAppReview inAppReview = InAppReview.instance;
                    inAppReview.openStoreListing();
                  }),
            ),
          ],
        ));
  }
}
