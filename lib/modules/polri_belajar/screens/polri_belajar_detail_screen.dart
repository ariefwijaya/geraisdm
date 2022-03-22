import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/env/env.dart';
import 'package:geraisdm/modules/doc_viewer/screens/components/keep_alive_component.dart';
import 'package:geraisdm/modules/polri_belajar/blocs/polri_belajar_bloc/polri_belajar_bloc.dart';
import 'package:geraisdm/modules/polri_belajar/blocs/polri_belajar_comment_bloc/polri_belajar_comment_bloc.dart';
import 'package:geraisdm/modules/polri_belajar/blocs/polri_belajar_comment_submit_bloc/polri_belajar_comment_submit_bloc.dart';
import 'package:geraisdm/modules/polri_belajar/models/polri_belajar_model.dart';
import 'package:geraisdm/modules/polri_belajar/screens/components/polri_belajar_comment_modal.dart';
import 'package:geraisdm/utils/helpers/launcher_helper.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/widgets/general_component.dart';
import 'package:geraisdm/widgets/image_viewer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PolriBelajarDetailScreen extends StatefulWidget {
  final int id;
  final int? refId;
  final String? title;

  const PolriBelajarDetailScreen(
      {Key? key,
      @pathParam required this.id,
      @queryParam this.title,
      @queryParam this.refId})
      : super(key: key);

  @override
  State<PolriBelajarDetailScreen> createState() =>
      _PolriBelajarDetailScreenState();
}

class _PolriBelajarDetailScreenState extends State<PolriBelajarDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => getIt.get<PolriBelajarBloc>()
              ..add(PolriBelajarFetchDetail(
                  id: widget.id, refId: widget.refId!))),
        BlocProvider(create: (context) => getIt.get<PolriBelajarCommentBloc>()),
        BlocProvider(
            create: (context) => getIt.get<PolriBelajarCommentSubmitBloc>()),
      ],
      child: BlocListener<PolriBelajarBloc, PolriBelajarState>(
        listener: (context, state) {
          if (state is PolriBelajarDetailSuccess &&
              state.data.fileType == PolriBelajarFileType.pdf) {}
        },
        child: BlocBuilder<PolriBelajarBloc, PolriBelajarState>(
          builder: (context, state) {
            if (state is PolriBelajarDetailSuccess) {
              return _buildSuccess(context, data: state.data);
            }

            if (state is PolriBelajarFailure) {
              return _buildError(context);
            }

            return _buildLoading();
          },
        ),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context,
      {required PolriBelajarModel data}) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            leading: const RouteBackButton(),
            actions: [
              if (data.comments)
                Row(
                  children: [
                    Text(
                      "${data.totalComment}",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.comment,
                        size: 30,
                      ),
                      onPressed: () {
                        _showComments(context);
                      },
                    ),
                  ],
                ),
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
                  if (data.fileType == PolriBelajarFileType.pdf)
                    _buildPdf(context, data: data)
                  else if (data.fileType == PolriBelajarFileType.image)
                    _buildImage(context, data: data)
                  else if (data.fileType == PolriBelajarFileType.video)
                    _buildVideo(context, data: data)
                  else
                    Center(
                      child: Text(
                        LocaleKeys.polri_belajar_detail_file_type_unknown.tr(),
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

  Widget _buildPdf(BuildContext context, {required PolriBelajarModel data}) {
    final PageController pageController = PageController(keepPage: true);
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: PageView.builder(
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
      ),
    );
  }

  Widget _buildImage(BuildContext context, {required PolriBelajarModel data}) {
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

  Widget _buildVideo(BuildContext context, {required PolriBelajarModel data}) {
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

  Widget _buildError(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const RouteBackButton(),
        title: Text(widget.title ?? LocaleKeys.polri_belajar_detail_title.tr()),
      ),
      body: CommonPlaceholder.error(
          title: LocaleKeys.polri_belajar_detail_error_title.tr(),
          subtitle: LocaleKeys.polri_belajar_detail_error_subtitle.tr(),
          action: FilledButton.large(
              buttonText: LocaleKeys.polri_belajar_detail_error_retry.tr(),
              onPressed: () {
                context.read<PolriBelajarBloc>().add(PolriBelajarFetchDetail(
                    id: widget.id, refId: widget.refId!));
              })),
    );
  }

  Widget _buildLoading() {
    return Scaffold(
        appBar: AppBar(
          leading: const RouteBackButton(),
          title:
              Text(widget.title ?? LocaleKeys.polri_belajar_detail_title.tr()),
        ),
        body: const Center(child: CircularProgressIndicator()));
  }

  Future<void> _showComments(BuildContext context) async {
    context.router.pushWidget(PolriBelajarCommentModal(
      id: widget.id,
      refId: widget.refId!,
      title: widget.title,
    ));
  }
}
