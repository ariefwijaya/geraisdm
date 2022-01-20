import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/modules/bookmark/blocs/bookmark_list_bloc/bookmark_list_bloc.dart';
import 'package:geraisdm/modules/bookmark/models/bookmark_model.dart';
import 'package:geraisdm/modules/bookmark/screens/components/bookmark_card.dart';
import 'package:geraisdm/utils/helpers/launcher_helper.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookmarkListBloc>(
      create: (context) =>
          getIt.get<BookmarkListBloc>()..add(BookmarkListStarted()),
      child: Scaffold(
        appBar: AppBar(
          leading: const RouteBackButton(),
          title: Text(LocaleKeys.menu_bookmark_title.tr()),
        ),
        body: BlocBuilder<BookmarkListBloc, BookmarkListState>(
          builder: (context, state) {
            if (state is BookmarkListStartSuccess) {
              return RefreshIndicator(
                onRefresh: () => Future.sync(() =>
                    context.read<BookmarkListBloc>().add(BookmarkRefresh())),
                child: PagedListView<int, BookmarkModel>.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  pagingController: state.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<BookmarkModel>(
                    itemBuilder: (context, entry, index) {
                      return BookmarkCard(
                          title: entry.title,
                          imageUrl: entry.image,
                          date: DateFormat("d MMMM yyyy, hh:mm")
                              .format(entry.date),
                          onTap: () {
                            if (entry.actionType == BookmarkActionType.screen) {
                              context.router.pushNamed(entry.path!);
                            } else if (entry.actionType ==
                                BookmarkActionType.url) {
                              LauncherHelper.openUrl(entry.path!);
                            }
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
