import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/modules/complaint/blocs/complaint_list_bloc/complaint_list_bloc.dart';
import 'package:geraisdm/modules/complaint/models/complaint_model.dart';
import 'package:geraisdm/utils/helpers/launcher_helper.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ComplaintScreen extends StatelessWidget {
  const ComplaintScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ComplaintListBloc>(
      create: (context) =>
          getIt.get<ComplaintListBloc>()..add(ComplaintListStarted()),
      child: Scaffold(
        appBar: AppBar(
          leading: const RouteBackButton(),
          title: Text(LocaleKeys.profile_menu_complaint.tr()),
        ),
        body: BlocBuilder<ComplaintListBloc, ComplaintListState>(
          builder: (context, state) {
            if (state is ComplaintListStartSuccess) {
              return RefreshIndicator(
                onRefresh: () => Future.sync(() =>
                    context.read<ComplaintListBloc>().add(ComplaintRefresh())),
                child: PagedListView<int, ComplaintModel>.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  separatorBuilder: (context, index) => Divider(
                    height: 16,
                    color: Theme.of(context).highlightColor,
                    thickness: 2,
                  ),
                  pagingController: state.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<ComplaintModel>(
                    itemBuilder: (context, entry, index) {
                      return ListTile(
                        title: Text(entry.ticketNumber),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(entry.title, maxLines: 2),
                            Text(DateFormat("d MMMM yyyy, hh:mm")
                                .format(entry.createdDate)),
                          ],
                        ),
                        trailing: Text(
                          entry.status,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        onTap: () {
                          if (entry.actionType == ComplaintActionType.screen) {
                            context.router.pushNamed(entry.path!);
                          } else if (entry.actionType ==
                              ComplaintActionType.url) {
                            LauncherHelper.openUrl(entry.path!);
                          }
                        },
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
