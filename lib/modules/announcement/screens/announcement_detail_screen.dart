import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/env/env.dart';
import 'package:geraisdm/modules/announcement/blocs/announcement_bloc/announcement_bloc.dart';
import 'package:geraisdm/modules/announcement/blocs/announcement_like_bloc/announcement_like_bloc.dart';
import 'package:geraisdm/modules/announcement/models/announcement_model.dart';
import 'package:geraisdm/utils/helpers/launcher_helper.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/widgets/general_component.dart';
import 'package:geraisdm/widgets/image_viewer.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  final int id;
  final String? title;

  const AnnouncementDetailScreen(
      {Key? key, @pathParam required this.id, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => getIt.get<AnnouncementBloc>()
              ..add(AnnouncementFetchDetail(id: id))),
        BlocProvider(create: (context) => getIt.get<AnnouncementLikeBloc>()),
      ],
      child: BlocBuilder<AnnouncementBloc, AnnouncementState>(
        builder: (context, state) {
          if (state is AnnouncementDetailSuccess) {
            return _buildSuccess(context, data: state.data);
          }

          if (state is AnnouncementFailure) {
            return _buildError(context);
          }

          return _buildLoading();
        },
      ),
    );
  }

  Widget _buildSuccess(BuildContext context,
      {required AnnouncementModel data}) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            leading: const RouteBackButton(),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.share,
                  size: 30,
                ),
                onPressed: () {
                  LauncherHelper.share(
                      data.title + "\n" + (data.linkShare ?? ""),
                      subject: Env.appName);
                },
              )
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          data.title,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      const SizedBox(width: 8),
                      BlocBuilder<AnnouncementLikeBloc, AnnouncementLikeState>(
                        builder: (context, state) {
                          bool liked = data.liked;

                          if (state is AnnouncementLikeSuccess) {
                            liked = state.liked;
                          }

                          return IconButton(
                              onPressed: () {
                                context.read<AnnouncementLikeBloc>().add(
                                    AnnouncementLikeStart(
                                        id: id, like: !liked));
                              },
                              icon: Icon(
                                Icons.favorite,
                                size: 30,
                                color: liked
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).highlightColor,
                              ));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          DateFormat("d MMM yyyy, hh:mm").format(data.date),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.person,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              data.author,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Divider(
                      thickness: 2,
                      color: Theme.of(context).highlightColor,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      onTap: () {
                        if (data.image != null) {
                          context.router.pushWidget(
                              ImageGalleryViewer(imageUrls: [data.image!]),
                              fullscreenDialog: true);
                        }
                      },
                      child: ImagePlaceholder(
                        imageUrl: data.image,
                        height: 180,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  if (data.content != null)
                    HtmlViewer(htmlString: data.content!)
                  else
                    Center(
                      child: Text(
                        LocaleKeys.announcement_detail_notfound_title.tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline4,
                      ),
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
        title: Text(title ?? LocaleKeys.announcement_detail_title.tr()),
      ),
      body: CommonPlaceholder.error(
          title: LocaleKeys.announcement_detail_error_title.tr(),
          subtitle: LocaleKeys.announcement_detail_error_subtitle.tr(),
          action: FilledButton.large(
              buttonText: LocaleKeys.announcement_detail_error_retry.tr(),
              onPressed: () {
                context
                    .read<AnnouncementBloc>()
                    .add(AnnouncementFetchDetail(id: id));
              })),
    );
  }

  Widget _buildLoading() {
    return Scaffold(
        appBar: AppBar(
          leading: const RouteBackButton(),
          title: Text(title ?? LocaleKeys.announcement_detail_title.tr()),
        ),
        body: const Center(child: CircularProgressIndicator()));
  }
}
