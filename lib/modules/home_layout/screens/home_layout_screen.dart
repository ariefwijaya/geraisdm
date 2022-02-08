import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/core/auth/blocs/auth_bloc.dart';
import 'package:geraisdm/core/deeplink/blocs/deeplink_bloc/deeplink_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:geraisdm/core/notification/blocs/notification_bloc.dart';
import 'package:geraisdm/modules/home_layout/home_layout_config_bloc/home_layout_config_bloc.dart';
import 'package:geraisdm/modules/home_layout/models/layout_config_model.dart';
import 'package:geraisdm/modules/home_layout/screens/components/home_layout_content.dart';
import 'package:geraisdm/modules/inbox/blocs/inbox_counter_bloc/inbox_counter_bloc.dart';
import 'package:geraisdm/utils/helpers/launcher_helper.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/constant/assets.gen.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeLayoutConfigBloc>(
            create: (context) => getIt.get<HomeLayoutConfigBloc>()
              ..add(HomeLayoutConfigFetch())),
        BlocProvider(
            create: (context) => getIt.get<InboxCounterBloc>()
              ..add(const InboxCounterUnreadFetch()))
      ],
      child: Scaffold(
        body: MultiBlocListener(
          listeners: [
            BlocListener<DeeplinkBloc, DeeplinkState>(
              listener: (context, state) {
                if (state is DeeplinkNavigated) {
                  getIt
                      .get<AppRouter>()
                      .navigateNamed(state.path, includePrefixMatches: true);
                }
              },
            ),
            BlocListener<AuthBloc, AuthState>(listener: (context, state) {
              if (state is AuthUnauthenticated) {
                context.router.replaceAll([LoginRoute()]);
              }
            }),
            BlocListener<NotificationBloc, NotificationState>(
                listener: (context, state) {
              if (state is NotificationOpenUrl) {
                LauncherHelper.openUrl(state.url);
              } else if (state is NotificationNavigateScreen) {
                getIt.get<AppRouter>().navigateNamed(state.data.screenPath,
                    includePrefixMatches: true);
              }
            }),
            BlocListener<HomeLayoutConfigBloc, HomeLayoutConfigState>(
                listener: (context, state) {
              if (state is HomeLayoutConfigSuccess) {
                context.read<DeeplinkBloc>().add(DeeplinkStarted());
                context.read<NotificationBloc>().add(NotificationStarted());
              }
            }),
          ],
          child: BlocBuilder<HomeLayoutConfigBloc, HomeLayoutConfigState>(
            builder: (context, state) {
              if (state is HomeLayoutConfigSuccess) {
                return _buildSuccess(context, config: state.config);
              }

              if (state is HomeLayoutConfigFailure) {
                return _buildFailure(context);
              }

              return _buildLoading(context);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context,
      {required LayoutConfigModel config}) {
    final List<PageRouteInfo> listPage = [];
    final List<BottomNavigationBarItem> bottomNavBarItems = [];
    for (final item in config.menus) {
      switch (item.name) {
        case LayoutMenuType.history:
          listPage.add(const HistoryRouter());
          bottomNavBarItems.add(BottomNavigationBarItem(
              label: LocaleKeys.home_layout_menu_navbar_history.tr(),
              icon: const Icon(Icons.account_circle)));
          break;

        case LayoutMenuType.bookmark:
          listPage.add(const BookmarkRoute());
          bottomNavBarItems.add(BottomNavigationBarItem(
              label: LocaleKeys.home_layout_menu_navbar_likes.tr(),
              icon: const Icon(Icons.favorite)));
          break;

        case LayoutMenuType.home:
          listPage.add(const HomeRoute());
          bottomNavBarItems.add(BottomNavigationBarItem(
              label: LocaleKeys.home_layout_menu_navbar_home.tr(),
              icon: const Icon(Icons.home)));
          break;
        case LayoutMenuType.message:
          listPage.add(const InboxRoute());
          bottomNavBarItems.add(BottomNavigationBarItem(
              label: LocaleKeys.home_layout_menu_navbar_message.tr(),
              icon: BlocBuilder<InboxCounterBloc, InboxCounterState>(
                builder: (context, state) {
                  int totalUnread = 0;
                  if (state is InboxCounterUnreadTotal) {
                    totalUnread = state.total;
                  }
                  return GestureDetector(
                    onTap: () {
                      if (totalUnread > 0) {
                        context
                            .read<InboxCounterBloc>()
                            .add(const InboxCounterSetAsReadStart());
                      } else {
                        context.navigateTo(const InboxRoute());
                      }
                    },
                    child: Badge(
                        showBadge: totalUnread > 0,
                        badgeContent: Text(
                          '$totalUnread',
                          style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                        child: const Icon(Icons.inbox_rounded)),
                  );
                },
              )));
          break;

        case LayoutMenuType.profile:
          listPage.add(const ProfileRouter());
          bottomNavBarItems.add(BottomNavigationBarItem(
              label: LocaleKeys.home_layout_menu_navbar_profile.tr(),
              icon: const Icon(Icons.person)));
          break;
        default:
      }
    }

    return HomeLayoutContent(
        listPage: listPage, bottomNavBarItems: bottomNavBarItems);
  }

  Widget _buildFailure(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => context.read<AuthBloc>().add(AuthLogoutEv()),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
          margin: const EdgeInsets.all(24),
          child: CommonPlaceholder.noIcon(
              action: FilledButton.large(
                  buttonText: LocaleKeys.home_layout_failed_retry.tr(),
                  onPressed: () {
                    context
                        .read<HomeLayoutConfigBloc>()
                        .add(HomeLayoutConfigFetch());
                  }),
              title: LocaleKeys.home_layout_failed_title.tr(),
              subtitle: LocaleKeys.home_layout_failed_subtitle.tr())),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 80),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Assets.images.icon.logo.image(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).highlightColor,
                ),
              ),
            ],
          )),
    );
  }
}
