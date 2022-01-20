import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/modules/submenu/blocs/submenu_bloc/submenu_bloc.dart';
import 'package:geraisdm/modules/submenu/models/submenu_model.dart';
import 'package:geraisdm/utils/helpers/launcher_helper.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/widgets/components/menu_horizontal_card.dart';
import 'package:geraisdm/widgets/general_component.dart';

class SubmenuScreen extends StatelessWidget {
  final String? title;
  final int id;
  const SubmenuScreen(
      {Key? key, @queryParam this.title, @pathParam required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<SubmenuBloc>()..add(SubmenuFetch(id: id)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title ?? LocaleKeys.menu_sub_title.tr()),
        ),
        body: BlocBuilder<SubmenuBloc, SubmenuState>(
          builder: (context, state) {
            if (state is SubmenuSuccess) {
              if (state.listData.isNotEmpty) {
                return _buildSuccess(context, listData: state.listData);
              } else {
                return _buildNotFound();
              }
            }
            if (state is SubmenuFailure) {
              return _buildFailure(context);
            }
            return _buildLoading();
          },
        ),
      ),
    );
  }

  Widget _buildNotFound() {
    return Container(
      margin: const EdgeInsets.all(24),
      child: CommonPlaceholder.noIcon(
        title: LocaleKeys.menu_sub_nodata_title.tr(),
        subtitle: LocaleKeys.menu_sub_nodata_subtitle.tr(),
      ),
    );
  }

  Widget _buildFailure(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      child: CommonPlaceholder.noIcon(
          title: LocaleKeys.menu_sub_failure_title.tr(),
          subtitle: LocaleKeys.menu_sub_failure_subtitle.tr(),
          action: FilledButton.large(
              infiniteWidth: false,
              buttonText: LocaleKeys.menu_sub_failure_retry.tr(),
              onPressed: () {
                context.read<SubmenuBloc>().add(SubmenuFetch(id: id));
              })),
    );
  }

  Widget _buildLoading() {
    return SingleChildScrollView(
      child: Column(
          children: List.generate(
              5,
              (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: const [
                        SkeletonLoaderSquare(
                            roundedRadius: 16,
                            width: double.infinity,
                            height: 80),
                        SizedBox(
                          height: 16,
                        )
                      ],
                    ),
                  ))),
    );
  }

  Widget _buildSuccess(BuildContext context,
      {required List<SubmenuModel> listData}) {
    return ListView.separated(
        itemBuilder: (context, index) {
          final data = listData[index];
          return MenuHorizontalCard(
            name: data.name,
            locked: data.locked,
            description: data.description,
            icon: data.icon,
            onTap: () {
              if (data.actionType == SubmenuActionType.screen) {
                getIt
                    .get<AppRouter>()
                    .navigateNamed(data.path!, includePrefixMatches: true);
              } else if (data.actionType == SubmenuActionType.url) {
                LauncherHelper.openUrl(data.path!);
              }
            },
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
        itemCount: listData.length);
  }
}
