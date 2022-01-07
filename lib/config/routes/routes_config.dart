import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:catcher/core/catcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/button_component.dart';
import '../../../../widgets/icon_alert_component.dart';
import '../../../../constant/localizations.g.dart';
import '../../../../widgets/alert_component.dart';
import '../../core/auth/repositories/auth_repository_interface.dart';
import 'package:injectable/injectable.dart';

import 'routes.gr.dart';

@injectable
class AuthGuard extends AutoRouteGuard {
  final AuthRepositoryInterface authRepository;

  AuthGuard({required this.authRepository});

  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation
    try {
      final activeSession = await authRepository.getLoggedinSession();
      if (activeSession != null) {
        // if user is autenticated we continue
        resolver.next();
      } else {
        // we redirect the user to our login page
        final bool? success = await router.push<bool?>(LoginRoute());
        if (success != null && success) {
          resolver.next();
        } else {
          resolver.next(false);
        }
      }
    } catch (e, s) {
      final context = router.navigatorKey.currentContext;
      Catcher.reportCheckedError(e, s);
      if (context != null) {
        final bool? success = await showAlertError(context);
        if (success != null && success) {
          return resolver.next();
        }
      }
      resolver.next(false);
    }
  }

  Future<bool?> showAlertError(BuildContext context) {
    return showModalBottomSheet<bool?>(
        context: context,
        builder: (context) => CDialogCard(
              title: LocaleKeys.router_auth_failed_title.tr(),
              description: LocaleKeys.router_auth_failed_subtitle.tr(),
              icon: const ErrorIconPlaceholder(),
              actionWidget: Row(
                children: [
                  Expanded(
                    child: FilledButton.large(
                        infiniteWidth: false,
                        buttonText: LocaleKeys.router_auth_failed_ok.tr(),
                        onPressed: () => context.router.pop()),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: GhostButton.large(
                        infiniteWidth: false,
                        buttonText: LocaleKeys.router_auth_relogin.tr(),
                        onPressed: () async {
                          final success =
                              await context.router.push(LoginRoute());
                          context.router.pop(success);
                        }),
                  )
                ],
              ),
            ));
  }
}
