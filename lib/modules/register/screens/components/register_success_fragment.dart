import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/constant/localizations.g.dart';

class RegisterSuccessFragment extends StatelessWidget {
  const RegisterSuccessFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CommonPlaceholder.success(
          title: LocaleKeys.register_activation_success_title.tr(),
          subtitle: LocaleKeys.register_activation_success_hint,
          action: FilledButton.large(
              buttonText: LocaleKeys.login_button.tr(),
              onPressed: () {
                context.router.popAndPush(LoginRoute());
              })),
    );
  }
}
