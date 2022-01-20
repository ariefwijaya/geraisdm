import 'package:flutter/material.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/constant/assets.gen.dart';

class General404Screen extends StatelessWidget {
  const General404Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const RouteBackButton(),
      ),
      body: CommonPlaceholder.customIcon(
          icon: Assets.images.illustration.lightTheFire
              .image(width: 100, height: 100),
          title: LocaleKeys.notfound_screen_title.tr(),
          subtitle: LocaleKeys.notfound_screen_subtitle.tr()),
    );
  }
}
