import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/modules/history/blocs/history_list_bloc/history_list_bloc.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/modules/history/models/history_model.dart';
import 'package:geraisdm/utils/helpers/format_helper.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HistoryListBloc>(
      create: (context) =>
          getIt.get<HistoryListBloc>()..add(HistoryListStarted()),
      child: Scaffold(
        appBar: AppBar(
          leading: const RouteBackButton(),
          title: Text(LocaleKeys.menu_history_activity_title.tr()),
        ),
        body: BlocBuilder<HistoryListBloc, HistoryListState>(
          builder: (context, state) {
            if (state is HistoryListStartSuccess) {
              return RefreshIndicator(
                onRefresh: () => Future.sync(() =>
                    context.read<HistoryListBloc>().add(HistoryRefresh())),
                child: PagedListView<int, HistoryModel>.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  pagingController: state.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<HistoryModel>(
                    itemBuilder: (context, entry, index) {
                      return Card(
                        elevation: 5,
                        shadowColor:
                            Theme.of(context).shadowColor.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: ListTile(
                          title: Text(
                            entry.serviceName,
                          ),
                          subtitle: Text(DateFormat("d MMMM yyyy, hh:mm")
                              .format(entry.createdDate)),
                          trailing: Text(
                            FormatHelper.enumName(entry.status).toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: _getStatusColor(entry.status)),
                          ),
                          onTap: () {
                            context.pushRoute(HistoryDetailRoute(id: entry.id));
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

  Color _getStatusColor(HistoryStatus status) {
    switch (status) {
      case HistoryStatus.accepted:
        return Colors.green;
      case HistoryStatus.rejected:
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }
}
