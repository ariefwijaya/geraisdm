import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/modules/articles/models/article_model.dart';
import 'package:geraisdm/modules/home/blocs/home_article_banner_bloc/home_article_banner_bloc.dart';
import 'package:geraisdm/utils/helpers/launcher_helper.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/widgets/general_component.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeArticleSection extends StatelessWidget {
  final int? maxItem;
  const HomeArticleSection({Key? key, this.maxItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeArticleBannerBloc, HomeArticleBannerState>(
      builder: (context, state) {
        if (state is HomeArticleBannerSuccess) {
          List<ArticleModel> datas = [];
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

          return _buildSuccess(datas);
        }
        if (state is HomeArticleBannerFailure) {
          return _buildFailure(context);
        }
        return _buildLoading();
      },
    );
  }

  Widget _buildLoading() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: const SkeletonLoaderSquare(
        height: 130,
        width: double.infinity,
        roundedRadius: 15,
      ),
    );
  }

  Widget _buildFailure(BuildContext context) {
    return Container(
      height: 130,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).dividerColor,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(LocaleKeys.home_config_failed_title.tr()),
          const SizedBox(height: 8),
          GhostButton.small(
              infiniteWidth: false,
              buttonText: LocaleKeys.home_config_failed_retry.tr(),
              onPressed: () {
                context
                    .read<HomeArticleBannerBloc>()
                    .add(HomeArticleBannerFetch());
              })
        ],
      ),
    );
  }

  Widget _buildSuccess(List<ArticleModel> listData) {
    final PageController pageController =
        PageController(viewportFraction: listData.length <= 1 ? 0.95 : 0.9);

    return SizedBox(
      height: 130,
      child: PageView.builder(
          controller: pageController,
          padEnds: listData.length <= 1,
          itemBuilder: (context, index) {
            final data = listData[index];
            return InkWell(
              onTap: () {
                if (data.actionType == ArticleActionType.screen) {
                  getIt
                      .get<AppRouter>()
                      .navigateNamed(data.path!, includePrefixMatches: true);
                } else if (data.actionType == ArticleActionType.url) {
                  LauncherHelper.openUrl(data.path!);
                }
              },
              child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: listData.length <= 1 ? 8 : 12),
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
                                    Theme.of(context)
                                        .shadowColor
                                        .withOpacity(0.5),
                                    Colors.transparent,
                                  ])),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        left: 15,
                        right: 15,
                        child: Text(
                          data.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                        ),
                      )
                    ],
                  )),
            );
          },
          itemCount: listData.length),
    );
  }
}
