import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/modules/detail_menu/blocs/detail_menu_bloc/detail_menu_bloc.dart';
import 'package:geraisdm/modules/detail_menu/models/detail_menu_model.dart';
import 'package:geraisdm/modules/submenu/models/submenu_model.dart';
import 'package:geraisdm/utils/helpers/launcher_helper.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/widgets/components/menu_horizontal_card.dart';

class DetailMenuScreen extends StatelessWidget {
  final int id;
  final String? title;
  const DetailMenuScreen(
      {Key? key, @pathParam required this.id, @queryParam this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt.get<DetailMenuBloc>()..add(DetailMenuFetch(id: id)),
      child: Scaffold(
        appBar: AppBar(
          leading: const AutoBackButton(),
          title: Text(title ?? ""),
        ),
        body: BlocBuilder<DetailMenuBloc, DetailMenuState>(
          builder: (context, state) {
            if (state is DetailMenuSuccess) {
              return _buildSuccess(context, data: state.data);
            }
            if (state is DetailMenuFailure) {
              return _buildError(context);
            }
            return _buildLoading();
          },
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    return CommonPlaceholder.error(
        title: LocaleKeys.detail_menu_failure_title.tr(),
        subtitle: LocaleKeys.detail_menu_failure_subtitle.tr(),
        action: FilledButton.large(
            buttonText: LocaleKeys.detail_menu_failure_retry.tr(),
            onPressed: () {
              context.read<DetailMenuBloc>().add(DetailMenuFetch(id: id));
            }));
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildSuccess(BuildContext context, {required DetailMenuModel data}) {
    return ListView(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      data.subtitle,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            ImagePlaceholder(
              height: 100,
              width: 100,
              imageUrl: data.icon,
              imageFit: BoxFit.cover,
            ),
          ],
        ),
        Divider(
          height: 16,
          thickness: 1,
          color: Theme.of(context).highlightColor,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text(data.description ?? "-"),
        ),
        const SizedBox(height: 8),
        if (data.navigation.isNotEmpty)
          Column(
            children: data.navigation
                .map((e) => Column(
                      children: [
                        MenuHorizontalCard(
                          name: e.name,
                          description: e.description,
                          enableActionIcon: e.locked,
                          icon: e.icon,
                          locked: e.locked,
                          onTap: () {
                            if (e.actionType == SubmenuActionType.screen) {
                              getIt.get<AppRouter>().pushNamed(e.path!,
                                  includePrefixMatches: true);
                            } else if (e.actionType == SubmenuActionType.url) {
                              LauncherHelper.openUrl(e.path!);
                            }
                          },
                        ),
                        const SizedBox(height: 8)
                      ],
                    ))
                .toList(),
          )
      ],
    );
  }
}
