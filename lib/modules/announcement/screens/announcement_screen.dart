import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/modules/announcement/blocs/announcement_list_bloc/announcement_list_bloc.dart';
import 'package:geraisdm/modules/announcement/models/announcement_model.dart';
import 'package:geraisdm/modules/announcement/screens/components/announcement_card.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AnnouncementListBloc>(
      create: (context) =>
          getIt.get<AnnouncementListBloc>()..add(AnnouncementListStarted()),
      child: Scaffold(
        appBar: AppBar(
          leading: const RouteBackButton(),
          title: Text(LocaleKeys.announcement_title.tr()),
        ),
        body: BlocBuilder<AnnouncementListBloc, AnnouncementListState>(
          builder: (context, state) {
            if (state is AnnouncementListStartSuccess) {
              return RefreshIndicator(
                onRefresh: () => Future.sync(() => context
                    .read<AnnouncementListBloc>()
                    .add(AnnouncementRefresh())),
                child: PagedListView<int, AnnouncementModel>.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  pagingController: state.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<AnnouncementModel>(
                    itemBuilder: (context, entry, index) {
                      return AnnouncementCard(
                          title: entry.title,
                          imageUrl: entry.image,
                          date: DateFormat("d MMMM yyyy, hh:mm")
                              .format(entry.date),
                          onTap: () {
                            context.router.push(AnnouncementDetailRoute(
                                id: entry.id, title: entry.title));
                          });
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
