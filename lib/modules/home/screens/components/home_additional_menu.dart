import 'package:flutter/material.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/modules/home/models/home_menu_model.dart';
import 'package:geraisdm/utils/helpers/launcher_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:geraisdm/widgets/components/menu_horizontal_card.dart';

class HomeAdditionalMenu extends StatelessWidget {
  final List<HomeMenuModel> datas;
  const HomeAdditionalMenu({Key? key, required this.datas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.home_menu_service_more.tr()),
      ),
      body: ListView.separated(
          itemCount: datas.length,
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          },
          itemBuilder: (context, index) {
            final data = datas[index];
            return MenuHorizontalCard(
              enableActionIcon: true,
              name: data.name,
              onTap: () {
                if (data.actionType == HomeMenuActionType.screen) {
                  getIt
                      .get<AppRouter>()
                      .navigateNamed(data.path!, includePrefixMatches: true);
                } else if (data.actionType == HomeMenuActionType.url) {
                  LauncherHelper.openUrl(data.path!);
                }
              },
              description: data.description,
              icon: data.icon,
              locked: data.locked,
            );
          }),
    );
  }
}
