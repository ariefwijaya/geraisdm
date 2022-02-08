import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/modules/inbox/blocs/inbox_counter_bloc/inbox_counter_bloc.dart';
import 'package:geraisdm/modules/inbox/blocs/inbox_list_bloc/inbox_list_bloc.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/modules/inbox/models/inbox_model.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InboxListBloc>(
      create: (context) => getIt.get<InboxListBloc>()..add(InboxListStarted()),
      child: Scaffold(
        appBar: AppBar(
          leading: const RouteBackButton(),
          title: Text(LocaleKeys.menu_inbox_title.tr()),
        ),
        body: BlocBuilder<InboxListBloc, InboxListState>(
          builder: (context, state) {
            if (state is InboxListStartSuccess) {
              return RefreshIndicator(
                onRefresh: () => Future.sync(
                    () => context.read<InboxListBloc>().add(InboxRefresh())),
                child: PagedListView<int, InboxModel>.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  pagingController: state.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<InboxModel>(
                    itemBuilder: (context, entry, index) {
                      return BlocProvider(
                        create: (context) => getIt.get<InboxCounterBloc>()
                          ..add(InboxCounterUnreadFetch(id: entry.id)),
                        child: BlocBuilder<InboxCounterBloc, InboxCounterState>(
                          builder: (context, state) {
                            int totalUnread = entry.unreadTotal;
                            if (state is InboxCounterUnreadTotal) {
                              totalUnread = state.total;
                            }
                            return Badge(
                              showBadge: totalUnread > 0,
                              position: BadgePosition.bottomEnd(),
                              badgeContent: Text(
                                '$totalUnread',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                              ),
                              child: Card(
                                elevation: 5,
                                shadowColor: Theme.of(context)
                                    .shadowColor
                                    .withOpacity(0.3),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: ListTile(
                                  title: Text(
                                    entry.serviceName,
                                  ),
                                  subtitle: Text(
                                      DateFormat("d MMMM yyyy, hh:mm")
                                          .format(entry.createdDate)),
                                  trailing: entry.status ==
                                          InboxStatus.delivered
                                      ? const Icon(Icons.check,
                                          color: Colors.green)
                                      : entry.status == InboxStatus.read
                                          ? const Icon(Icons.checklist_sharp)
                                          : const Icon(Icons.device_unknown),
                                  onTap: () {
                                    context.read<InboxCounterBloc>().add(
                                        InboxCounterSetAsReadStart(
                                            id: entry.id));
                                    context.pushRoute(InboxDetailRoute(
                                        id: entry.id,
                                        title: entry.serviceName));
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
