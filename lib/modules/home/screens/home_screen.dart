import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/modules/home/blocs/home_announcement_bloc/home_announcement_bloc.dart';
import 'package:geraisdm/modules/home/blocs/home_article_banner_bloc/home_article_banner_bloc.dart';
import 'package:geraisdm/modules/home/blocs/home_bloc/home_bloc.dart';
import 'package:geraisdm/modules/home/blocs/home_config_bloc/home_config_bloc.dart';
import 'package:geraisdm/modules/home/blocs/home_menu_additional_bloc/home_menu_additional_bloc.dart';
import 'package:geraisdm/modules/home/blocs/home_menu_bloc/home_menu_bloc.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/modules/home/models/home_config_model.dart';
import 'package:geraisdm/modules/home/screens/sections/home_announcement_section.dart';
import 'package:geraisdm/modules/home/screens/sections/home_article_section.dart';
import 'package:geraisdm/modules/home/screens/sections/home_header_section.dart';
import 'package:geraisdm/modules/home/screens/sections/home_menu_section.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeConfigBloc>(
            create: (context) =>
                getIt.get<HomeConfigBloc>()..add(HomeConfigFetch())),
        BlocProvider<HomeArticleBannerBloc>(
            create: (context) => getIt.get<HomeArticleBannerBloc>()),
        BlocProvider<HomeMenuBloc>(
            create: (context) => getIt.get<HomeMenuBloc>()),
        BlocProvider<HomeMenuAdditionalBloc>(
            create: (context) => getIt.get<HomeMenuAdditionalBloc>()),
        BlocProvider<HomeAnnouncementBloc>(
            create: (context) => getIt.get<HomeAnnouncementBloc>()),
        BlocProvider<HomeBloc>(create: (context) => getIt.get<HomeBloc>()),
      ],
      child: BlocConsumer<HomeConfigBloc, HomeConfigState>(
        listener: (context, state) {
          if (state is HomeConfigSuccess) {
            _refreshHomeSection(context);
          }
        },
        builder: (context, state) {
          if (state is HomeConfigSuccess) {
            return _buildConfigSuccess(context, homeConfigModel: state.data);
          }
          if (state is HomeConfigFailure) {
            return _buildConfigFailure(context);
          }

          return _buildConfigLoading();
        },
      ),
    );
  }

  Widget _buildConfigSuccess(BuildContext context,
      {required HomeConfigModel homeConfigModel}) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(
        () => _refreshHomeSection(context),
      ),
      child: Scaffold(
        body: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: generateSections(context, homeConfigModel),
        ),
      ),
    );
  }

  Widget _buildConfigLoading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildConfigFailure(BuildContext context) {
    return Scaffold(
      body: CommonPlaceholder.noIcon(
          title: LocaleKeys.home_config_failed_title.tr(),
          subtitle: LocaleKeys.home_config_failed_subtitle.tr(),
          action: FilledButton.large(
              buttonText: LocaleKeys.home_config_failed_retry.tr(),
              onPressed: () =>
                  context.read<HomeConfigBloc>().add(HomeConfigFetch()))),
    );
  }

  List<Widget> generateSections(BuildContext context, HomeConfigModel config) {
    final List<Widget> widgetSections = [];
    for (final item in config.sections) {
      switch (item.name) {
        case HomeSectionType.articleBanner:
          if (item.enable) {
            final config = item.config;
            widgetSections.add(HomeArticleSection(
              maxItem: config?.maxItem,
            ));
          }
          break;
        case HomeSectionType.menuList:
          if (item.enable) {
            final config = item.config;
            widgetSections.add(HomeMenuSection(
              maxItem: config?.maxItem,
              moreButton: config?.enableActionButton ?? false,
            ));
          }
          break;

        case HomeSectionType.announcement:
          if (item.enable) {
            final config = item.config;
            widgetSections.add(HomeAnnouncementSection(
              maxItem: config?.maxItem,
              actionButton: config?.enableActionButton ?? false,
            ));
          }
          break;

        case HomeSectionType.divider:
          if (item.enable) {
            final config = item.config;
            widgetSections.add(Divider(
              height: config?.size,
            ));
          }
          break;

        default:
      }
    }

    final List<Widget> widgetCore = [const HomeHeaderSection()];

    if (widgetSections.isNotEmpty) {
      widgetCore.add(Container(
        color: Theme.of(context).indicatorColor,
        child: Column(
          children: widgetSections,
        ),
      ));

      widgetCore.add(Container(
          color: Theme.of(context).scaffoldBackgroundColor, height: 30));
    }
    return widgetCore;
  }

  void _refreshHomeSection(BuildContext context) {
    context.read<HomeBloc>().add(HomeFetchHeader());
    context.read<HomeAnnouncementBloc>().add(HomeAnnouncementFetch());
    context.read<HomeMenuBloc>().add(HomeMenuFetch());
    context.read<HomeMenuAdditionalBloc>().add(HomeMenuAdditionalFetch());
    context.read<HomeArticleBannerBloc>().add(HomeArticleBannerFetch());
  }
}
