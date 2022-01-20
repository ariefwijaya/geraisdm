import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/modules/announcement/models/announcement_model.dart';
import 'package:geraisdm/modules/home/blocs/home_announcement_bloc/home_announcement_bloc.dart';
import 'package:geraisdm/modules/home/screens/components/home_title_divider.dart';
import 'package:geraisdm/utils/helpers/launcher_helper.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/widgets/general_component.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeAnnouncementSection extends StatelessWidget {
  final int? maxItem;
  final bool actionButton;
  const HomeAnnouncementSection(
      {Key? key, this.maxItem, this.actionButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeAnnouncementBloc, HomeAnnouncementState>(
      builder: (context, state) {
        if (state is HomeAnnouncementSuccess) {
          List<AnnouncementModel> datas = [];
          if (maxItem != null && maxItem! <= state.listData.length) {
            for (var i = 0; i < maxItem!; i++) {
              datas.add(state.listData[i]);
            }
          } else {
            datas = state.listData;
          }

          if (datas.isEmpty) {
            return Container();
          }

          return _buildSuccess(context,
              listData: datas, actionButton: actionButton);
        }
        if (state is HomeAnnouncementFailure) {
          return _buildFailure(context);
        }
        return _buildLoading(context);
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeTitleDivider(
              title: LocaleKeys.home_section_announcement_title.tr(),
            ),
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 0.94,
              physics:
                  const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
              shrinkWrap: true, // You won't see infinite size error
              children: List.generate(
                  4,
                  (index) => const SkeletonLoaderSquare(
                      roundedRadius: 15, width: 80, height: 80)),
            ),
          ],
        ));
  }

  Widget _buildFailure(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          HomeTitleDivider(
            title: LocaleKeys.home_section_announcement_title.tr(),
          ),
          Container(
            height: 160,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(LocaleKeys.home_config_failed_title.tr()),
                const SizedBox(height: 8),
                GhostButton.medium(
                    infiniteWidth: false,
                    buttonText: LocaleKeys.home_config_failed_retry.tr(),
                    onPressed: () {
                      context
                          .read<HomeAnnouncementBloc>()
                          .add(HomeAnnouncementFetch());
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccess(BuildContext context,
      {required List<AnnouncementModel> listData, bool actionButton = false}) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: HomeTitleDivider(
            title: LocaleKeys.home_section_announcement_title.tr(),
            onTap: actionButton
                ? () {
                    context.pushRoute(const AnnouncementRouter());
                  }
                : null,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 0.94,
          physics:
              const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
          shrinkWrap: true, // You won't see infinite size error
          children: listData.map((data) {
            return InkWell(
              onTap: () {
                if (data.actionType == AnnouncementActionType.screen) {
                  getIt
                      .get<AppRouter>()
                      .navigateNamed(data.path!, includePrefixMatches: true);
                } else if (data.actionType == AnnouncementActionType.url) {
                  LauncherHelper.openUrl(data.path!);
                }
              },
              child: Stack(
                children: [
                  ImagePlaceholder(
                    imageUrl: data.image,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Theme.of(context).shadowColor.withOpacity(0.5),
                                Colors.transparent,
                              ])),
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    left: 15,
                    right: 15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title,
                          maxLines: 2,
                          style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          LocaleKeys.announcement_author_by
                              .tr(args: [data.author]),
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          DateFormat("d MMM yyyy, hh:mm").format(data.date),
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
