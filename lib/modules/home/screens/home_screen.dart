import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/modules/doc_viewer/screens/components/keep_alive_component.dart';
import 'package:geraisdm/modules/home/blocs/home_announcement_bloc/home_announcement_bloc.dart';
import 'package:geraisdm/modules/home/blocs/home_article_banner_bloc/home_article_banner_bloc.dart';
import 'package:geraisdm/modules/home/blocs/home_bloc/home_bloc.dart';
import 'package:geraisdm/modules/home/blocs/home_config_bloc/home_config_bloc.dart';
import 'package:geraisdm/modules/home/blocs/home_menu_bloc/home_menu_bloc.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/modules/home/models/home_config_model.dart';
import 'package:geraisdm/modules/home/screens/sections/home_announcement_section.dart';
import 'package:geraisdm/modules/home/screens/sections/home_article_section.dart';
import 'package:geraisdm/modules/home/screens/sections/home_header_section.dart';
import 'package:geraisdm/modules/home/screens/sections/home_menu_section.dart';
import 'package:geraisdm/modules/home/screens/sections/home_searchbar_section.dart';
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
        // BlocProvider<HomeMenuAdditionalBloc>(
        //     create: (context) => getIt.get<HomeMenuAdditionalBloc>()),
        BlocProvider<HomeAnnouncementBloc>(
            create: (context) => getIt.get<HomeAnnouncementBloc>()),
        BlocProvider<HomeBloc>(create: (context) => getIt.get<HomeBloc>()),
      ],
      child: BlocBuilder<HomeConfigBloc, HomeConfigState>(
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
    final dataSections =
        homeConfigModel.sections.where((element) => element.enable).toList();
    return RefreshIndicator(
      onRefresh: () => Future.sync(
        () => _refreshHomeSection(context),
      ),
      child: Scaffold(
          body: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 20),
              itemBuilder: (context, index) {
                final item = dataSections[index];
                final itemWidget = generateSections(item);
                if (itemWidget != null) {
                  return KeepAliveComponent(child: itemWidget);
                } else {
                  return Container();
                }
              },
              itemCount: dataSections.length)),
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

  Widget? generateSections(HomeSectionModel item) {
    switch (item.name) {
      case HomeSectionType.header:
        return const HomeHeaderSection();
      case HomeSectionType.searchbar:
        return const HomeSearchbarSection();
      case HomeSectionType.articleBanner:
        final config = item.config;
        return HomeArticleSection(
          maxItem: config?.maxItem,
        );
      case HomeSectionType.menuList:
        final config = item.config;
        return (HomeMenuSection(
          maxItem: config?.maxItem,
          moreButton: config?.enableActionButton ?? false,
        ));

      case HomeSectionType.announcement:
        final config = item.config;
        return HomeAnnouncementSection(
          maxItem: config?.maxItem,
          actionButton: config?.enableActionButton ?? false,
        );

      case HomeSectionType.divider:
        final config = item.config;
        return Divider(
          height: config?.size,
        );

      default:
        return null;
    }
  }

  void _refreshHomeSection(BuildContext context) {
    context.read<HomeConfigBloc>().add(HomeConfigFetch());
  }
}
