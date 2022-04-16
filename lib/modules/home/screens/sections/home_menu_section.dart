import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/modules/home/blocs/home_menu_bloc/home_menu_bloc.dart';
import 'package:geraisdm/modules/home/models/home_menu_model.dart';
import 'package:geraisdm/modules/home/screens/components/home_additional_menu.dart';
import 'package:geraisdm/utils/helpers/launcher_helper.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/widgets/general_component.dart';

class HomeMenuSection extends StatelessWidget {
  final int? maxItem;
  final bool moreButton;
  const HomeMenuSection({Key? key, this.maxItem, this.moreButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HomeMenuBloc>().add(HomeMenuFetch());
    return BlocBuilder<HomeMenuBloc, HomeMenuState>(
      builder: (context, state) {
        if (state is HomeMenuListSuccess) {
          List<HomeMenuModel> datas = [];
          List<HomeMenuModel> datasAdditional = [];
          if (maxItem != null && maxItem! <= state.listData.length) {
            for (var i = 0; i < state.listData.length; i++) {
              if (i < maxItem!) {
                datas.add(state.listData[i]);
              } else {
                datasAdditional.add(state.listData[i]);
              }
            }
          } else {
            datas = state.listData;
          }

          if (datas.isEmpty) {
            return Container();
          }

          return _buildSuccess(context,
              list: datas, listAdditional: datasAdditional);
        }
        if (state is HomeMenuFailure) {
          return _buildFailure(context);
        }
        return _buildLoading();
      },
    );
  }

  Widget _buildLoading() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          physics:
              const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
          shrinkWrap: true, // You won't see infinite size error
          children: List.generate(
              6,
              (index) => const SkeletonLoaderSquare(
                  roundedRadius: 15, width: 80, height: 80)),
        ));
  }

  Widget _buildFailure(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).dividerColor,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.home_config_failed_title.tr(),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          FilledButton.medium(
              infiniteWidth: false,
              buttonText: LocaleKeys.home_config_failed_retry.tr(),
              onPressed: () {
                context.read<HomeMenuBloc>().add(HomeMenuFetch());
              })
        ],
      ),
    );
  }

  Widget _buildSuccess(BuildContext context,
      {required List<HomeMenuModel> list,
      required List<HomeMenuModel> listAdditional}) {
    final List<Widget> gridChildren = [];

    for (final item in list) {
      gridChildren.add(Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: item.locked
              ? null
              : () {
                  if (item.actionType == HomeMenuActionType.screen) {
                    getIt
                        .get<AppRouter>()
                        .navigateNamed(item.path!, includePrefixMatches: true);
                  } else if (item.actionType == HomeMenuActionType.url) {
                    LauncherHelper.openUrl(item.path!);
                  }
                },
          child: Column(
            children: [
              Stack(
                children: [
                  ImagePlaceholder(
                    imageUrl: item.icon,
                    height: 80,
                    width: 80,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  if (item.locked)
                    Positioned.fill(
                      child: Container(
                        child: Icon(
                          Icons.lock,
                          size: 40,
                          color: Theme.of(context).disabledColor,
                        ),
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(18)),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  item.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ));
    }

    if (listAdditional.isNotEmpty && moreButton) {
      gridChildren.add(Column(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: IconButton(
              padding: EdgeInsets.zero,
              iconSize: 55,
              icon: Icon(
                Icons.grid_view_rounded,
                color: Theme.of(context).selectedRowColor,
              ),
              onPressed: () {
                context.router.pushWidget(
                    HomeAdditionalMenu(datas: listAdditional),
                    fullscreenDialog: true);
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              LocaleKeys.home_menu_more.tr(),
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ));
    }
    return GridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      crossAxisCount: 4,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 0.6,
      physics:
          const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
      shrinkWrap: true, // You won't see infinite size error
      children: gridChildren,
    );
  }
}
