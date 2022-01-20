import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/modules/history/blocs/history_bloc/history_bloc.dart';
import 'package:geraisdm/modules/history/models/history_detail_model.dart';
import 'package:geraisdm/modules/history/models/history_model.dart';
import 'package:geraisdm/modules/history/screens/components/history_rating_card.dart';
import 'package:geraisdm/utils/helpers/launcher_helper.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/constant/assets.gen.dart';

class HistoryDetailScreen extends StatelessWidget {
  final int id;
  const HistoryDetailScreen({Key? key, @pathParam required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt.get<HistoryBloc>()..add(HistoryFetchDetail(id: id)),
      child: Scaffold(
        appBar: AppBar(
          leading: const RouteBackButton(),
          title: Text(LocaleKeys.history_detail_title.tr()),
          actions: [
            IconButton(
                onPressed: () {
                  context.navigateTo(InboxDetailRoute(
                    id: id,
                  ));
                },
                icon: const Icon(Icons.chat))
          ],
        ),
        body: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            if (state is HistorySuccess) {
              return _buildSuccess(context, data: state.data);
            }
            if (state is HistoryFailure) {
              return _buildFailure(context);
            }

            return _buildLoading();
          },
        ),
      ),
    );
  }

  Widget _buildFailure(BuildContext context) {
    return CommonPlaceholder.customIcon(
        icon: Assets.images.illustration.warningCyt.image(height: 200),
        title: LocaleKeys.history_error_title.tr(),
        subtitle: LocaleKeys.history_error_subtitle.tr(),
        action: FilledButton.large(
            buttonText: LocaleKeys.history_error_retry.tr(),
            onPressed: () {
              context.read<HistoryBloc>().add(HistoryFetchDetail(id: id));
            }));
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildSuccess(BuildContext context,
      {required HistoryDetailModel data}) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        Text(
          data.title,
          style: Theme.of(context).textTheme.headline3,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    LocaleKeys.history_detail_status_created_date.tr(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    DateFormat("d MMM yyyy, hh:mm").format(data.createdDate),
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                )
              ],
            ),
          ],
        ),
        if (data.updatedDate != null) const SizedBox(height: 16),
        if (data.updatedDate != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      LocaleKeys.history_detail_status_updated_date.tr(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      DateFormat("d MMM yyyy, hh:mm").format(data.updatedDate!),
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  )
                ],
              ),
            ],
          ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    LocaleKeys.history_detail_status_title.tr(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    data.status.name.toUpperCase(),
                    textAlign: TextAlign.right,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: _getStatusColor(data.status)),
                  ),
                )
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    LocaleKeys.history_detail_file_upload.tr(),
                  ),
                ),
                const SizedBox(width: 16),
                NudeButton.small(
                    infiniteWidth: false,
                    buttonText: LocaleKeys.history_detail_file_view.tr(),
                    onPressed: () {
                      LauncherHelper.openUrl(data.fileUpload);
                    })
              ],
            ),
            if (data.fileDownload != null)
              Row(
                children: [
                  Expanded(
                    child: Text(
                      LocaleKeys.history_detail_file_download.tr(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  NudeButton.small(
                      infiniteWidth: false,
                      buttonText: LocaleKeys.history_detail_file_view.tr(),
                      onPressed: () {
                        LauncherHelper.openUrl(data.fileDownload!);
                      })
                ],
              ),
          ],
        ),
        Divider(
          color: Theme.of(context).highlightColor,
        ),
        HistoryRatingCard(
          id: id,
          initialRating: data.rating,
        ),
        Divider(
          color: Theme.of(context).highlightColor,
        ),
        const SizedBox(height: 16),
        if (data.forms.isNotEmpty)
          Column(
            children: [
              Text(LocaleKeys.history_detail_form_submission.tr(),
                  style: Theme.of(context).textTheme.headline4),
              Column(
                  children: data.forms
                      .map((e) => ListTile(
                            title: Text(e.title),
                            subtitle: Text(e.initialValue ??
                                LocaleKeys.history_detail_form_submission_nodata
                                    .tr()),
                          ))
                      .toList()),
            ],
          )
        else
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              LocaleKeys.history_detail_form_submission_nodata.tr(),
              textAlign: TextAlign.center,
            ),
          )
      ],
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
