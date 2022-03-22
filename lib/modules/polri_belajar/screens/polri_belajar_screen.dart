import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/modules/polri_belajar/blocs/polri_belajar_list_bloc/polri_belajar_list_bloc.dart';
import 'package:geraisdm/modules/polri_belajar/models/polri_belajar_model.dart';
import 'package:geraisdm/modules/polri_belajar/screens/components/polri_belajar_card.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PolriBelajarScreen extends StatelessWidget {
  final int? refId;
  const PolriBelajarScreen({Key? key, @QueryParam("ref_id") this.refId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PolriBelajarListBloc>(
      create: (context) => getIt.get<PolriBelajarListBloc>()
        ..add(PolriBelajarListStarted(refId!)),
      child: Scaffold(
        appBar: AppBar(
          leading: const RouteBackButton(),
          title: Text(LocaleKeys.polri_belajar_title.tr()),
        ),
        body: BlocBuilder<PolriBelajarListBloc, PolriBelajarListState>(
          builder: (context, state) {
            if (state is PolriBelajarListStartSuccess) {
              return RefreshIndicator(
                onRefresh: () => Future.sync(() => context
                    .read<PolriBelajarListBloc>()
                    .add(PolriBelajarRefresh())),
                child: PagedListView<int, PolriBelajarModel>.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  pagingController: state.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<PolriBelajarModel>(
                    itemBuilder: (context, entry, index) {
                      return PolriBelajarCard(
                          totalComment:
                              entry.comments ? entry.totalComment : null,
                          isTrending: entry.trending,
                          title: entry.title,
                          imageUrl: entry.image,
                          date: DateFormat("d MMMM yyyy, hh:mm")
                              .format(entry.date),
                          onTap: () {
                            context.router.push(PolriBelajarDetailRoute(
                                refId: refId,
                                id: entry.id,
                                title: entry.title));
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
