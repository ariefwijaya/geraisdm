import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/modules/detail_menu/blocs/detail_menu_tnc_bloc/detail_menu_tnc_bloc.dart';
import 'package:geraisdm/modules/detail_menu/models/detail_menu_tnc_model.dart';
import 'package:geraisdm/utils/helpers/launcher_helper.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/widgets/general_component.dart';
import 'package:geraisdm/constant/localizations.g.dart';

import 'package:geraisdm/constant/assets.gen.dart';

class DetailMenuTNCScreen extends StatelessWidget {
  final int id;
  const DetailMenuTNCScreen({Key? key, @pathParam required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt.get<DetailMenuTncBloc>()..add(DetailMenuTncFetch(id: id)),
      child: BlocBuilder<DetailMenuTncBloc, DetailMenuTncState>(
        builder: (context, state) {
          if (state is DetailMenuTncSuccess) {
            return _buildSuccess(context, data: state.data);
          }

          if (state is DetailMenuTncFailure) {
            return _buildError(context);
          }

          return _buildLoading();
        },
      ),
    );
  }

  Widget _buildSuccess(BuildContext context,
      {required DetailMenuTNCModel data}) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            snap: true,
            leading: RouteBackButton(),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  Text(
                    data.title,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    LocaleKeys.requirement_last_updated.tr(args: [
                      DateFormat("d MMM yyyy, hh:mm").format(data.dateUpdated)
                    ]),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Divider(
                      thickness: 2,
                      color: Theme.of(context).highlightColor,
                    ),
                  ),
                  if (data.content != null)
                    HtmlViewer(htmlString: data.content!)
                  else
                    Center(
                      child: Text(
                        LocaleKeys.requirement_detail_notfound_title.tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  if (data.listActions.isNotEmpty)
                    Column(
                      children: data.listActions
                          .map((e) => Column(
                                children: [
                                  FilledButton.large(
                                      buttonText: e.name.tr(),
                                      onPressed: () {
                                        if (e.actionType ==
                                            DetailMenuActionType.screen) {
                                          getIt.get<AppRouter>().navigateNamed(
                                              e.path!,
                                              includePrefixMatches: true);
                                        } else if (e.actionType ==
                                            DetailMenuActionType.url) {
                                          LauncherHelper.openUrl(e.path!);
                                        }
                                      }),
                                  const SizedBox(
                                    height: 16,
                                  )
                                ],
                              ))
                          .toList(),
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const RouteBackButton(),
        title: Text(LocaleKeys.requirement_detail_title.tr()),
      ),
      body: CommonPlaceholder.customIcon(
          icon: Assets.images.illustration.warningCyt.image(height: 200),
          title: LocaleKeys.requirement_detail_error_title.tr(),
          subtitle: LocaleKeys.requirement_detail_error_subtitle.tr(),
          action: FilledButton.large(
              buttonText: LocaleKeys.requirement_detail_error_retry.tr(),
              onPressed: () {
                context
                    .read<DetailMenuTncBloc>()
                    .add(DetailMenuTncFetch(id: id));
              })),
    );
  }

  Widget _buildLoading() {
    return Scaffold(
        appBar: AppBar(
          leading: const RouteBackButton(),
          title: Text(LocaleKeys.requirement_detail_title.tr()),
        ),
        body: const Center(child: CircularProgressIndicator()));
  }
}
