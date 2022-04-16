import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/env/env.dart';
import 'package:geraisdm/modules/announcement/blocs/announcement_bloc/announcement_bloc.dart';
import 'package:geraisdm/modules/announcement/blocs/announcement_like_bloc/announcement_like_bloc.dart';
import 'package:geraisdm/modules/announcement/models/announcement_model.dart';
import 'package:geraisdm/modules/doc_viewer/screens/components/keep_alive_component.dart';
import 'package:geraisdm/utils/helpers/launcher_helper.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/widgets/general_component.dart';
import 'package:geraisdm/widgets/image_viewer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
      appBar: AppBar(
        leading: const RouteBackButton(),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.share,
              size: 30,
            ),
            onPressed: () {
              LauncherHelper.share(data.title + "\n" + (data.linkShare ?? ""),
                  subject: Env.appName);
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          context
                              .read<AnnouncementLikeBloc>()
                              .add(AnnouncementLikeStart(id: id, like: !liked));
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
            Expanded(child: _buildFileType(context, data))
          ],
        ),
      ),
    );
  }

  Widget _buildFileType(BuildContext context, AnnouncementModel data) {
    if (data.fileType == AnnouncementFileType.pdf) {
      return _buildPdf(context, data: data);
    } else if (data.fileType == AnnouncementFileType.image) {
      return _buildImage(context, data: data);
    } else if (data.fileType == AnnouncementFileType.video) {
      return _buildVideo(context, data: data);
    } else {
      return Center(
        child: Text(
          LocaleKeys.polri_belajar_detail_file_type_unknown.tr(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4,
        ),
      );
    }
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

  Widget _buildPdf(BuildContext context, {required AnnouncementModel data}) {
    final PageController pageController = PageController(keepPage: true);
    return PageView.builder(
      controller: pageController,
      itemCount: data.files.length,
      itemBuilder: (context, index) {
        final file = data.files[index];
        return KeepAliveComponent(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      LocaleKeys.doc_viewer_of
                          .tr(args: ["${index + 1}", "${data.files.length}"]),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(width: 8),
                    if (data.description != null)
                      Expanded(
                        child: Text(
                          data.description!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: SfPdfViewer.network(
                  file.fileUrl,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImage(BuildContext context, {required AnnouncementModel data}) {
    return Column(
      children: [
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
        if (data.files.isNotEmpty)
          Column(
            children: data.files
                .map((e) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        onTap: () {
                          context.router.pushWidget(
                              ImageGalleryViewer(imageUrls: [e.fileUrl]),
                              fullscreenDialog: true);
                        },
                        child: ImagePlaceholder(
                          imageUrl: e.fileUrl,
                          height: 180,
                          width: double.infinity,
                        ),
                      ),
                    ))
                .toList(),
          ),
        if (data.content != null)
          HtmlViewer(htmlString: data.content!)
        else
          Center(
            child: Text(
              "-",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
          )
      ],
    );
  }

  Widget _buildVideo(BuildContext context, {required AnnouncementModel data}) {
    return Column(
      children: [
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
        if (data.files.isNotEmpty)
          Column(
            children: data.files.map((e) {
              if (e.idKey != null) {
                //youtube
                return Column(
                  children: [
                    SizedBox(
                        height: 200,
                        child: VideoYoutubeViewer(idKey: e.idKey!)),
                    const SizedBox(height: 10)
                  ],
                );
              }
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () {
                    context.router.pushWidget(
                        ImageGalleryViewer(imageUrls: [e.fileUrl]),
                        fullscreenDialog: true);
                  },
                  child: SizedBox(
                    height: 200,
                    child: VideoViewer(url: e.fileUrl),
                  ),
                ),
              );
            }).toList(),
          ),
        if (data.content != null)
          HtmlViewer(htmlString: data.content!)
        else
          Center(
            child: Text(
              "-",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
          )
      ],
    );
  }
}
