import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/modules/doc_viewer/blocs/doc_viewer_detail_bloc/doc_viewer_detail_bloc.dart';
import 'package:geraisdm/modules/doc_viewer/models/doc_viewer_detail_model.dart';
import 'package:geraisdm/modules/doc_viewer/screens/components/keep_alive_component.dart';
import 'package:geraisdm/utils/helpers/launcher_helper.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/constant/assets.gen.dart';
import 'package:geraisdm/widgets/general_component.dart';
import 'package:geraisdm/widgets/image_viewer.dart';
import 'package:screen_capture_event/screen_capture_event.dart';
import 'package:secure_application/secure_application.dart';
import 'package:secure_application/secure_gate.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DocViewerDetailScreen extends StatefulWidget {
  final int id;
  final String? title;
  final String? type;
  const DocViewerDetailScreen(
      {Key? key,
      @pathParam required this.id,
      @queryParam this.title,
      @queryParam this.type})
      : super(key: key);

  @override
  State<DocViewerDetailScreen> createState() => _DocViewerDetailScreenState();
}

class _DocViewerDetailScreenState extends State<DocViewerDetailScreen> {
  final ScreenCaptureEvent screenListener = ScreenCaptureEvent();
  late DocViewerDetailBloc docViewerDetailBloc;

  @override
  void initState() {
    docViewerDetailBloc = getIt.get<DocViewerDetailBloc>()
      ..add(DocViewerDetailFetch(id: widget.id, type: widget.type));

    super.initState();
  }

  @override
  void dispose() {
    screenListener.preventAndroidScreenShot(false);
    docViewerDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => docViewerDetailBloc,
      child: BlocConsumer<DocViewerDetailBloc, DocViewerDetailState>(
        bloc: docViewerDetailBloc,
        listener: (context, state) {
          if (state is DocViewerDetailSuccess) {
            screenListener.preventAndroidScreenShot(true);
          }
        },
        builder: (context, state) {
          if (state is DocViewerDetailSuccess) {
            return _buildSuccess(context, data: state.data);
          }

          if (state is DocViewerDetailFailure) {
            return _buildFailure(context);
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title ?? ""),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFailure(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ""),
      ),
      body: CommonPlaceholder.customIcon(
          icon: Assets.images.illustration.warningCyt.image(height: 200),
          title: LocaleKeys.doc_viewer_error_title.tr(),
          subtitle: LocaleKeys.doc_viewer_error_subtitle.tr(),
          action: FilledButton.large(
              buttonText: LocaleKeys.doc_viewer_error_retry.tr(),
              onPressed: () {
                docViewerDetailBloc.add(
                    DocViewerDetailFetch(id: widget.id, type: widget.type));
              })),
    );
  }

  Widget _buildSuccess(BuildContext context,
      {required DocViewerDetailModel data}) {
    return SecureGate(
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title ?? ""),
            actions: [
              IconButton(
                  onPressed: () {
                    if (data.linkShare != null) {
                      LauncherHelper.share(
                          data.description + "\n" + data.linkShare!);
                    }
                  },
                  icon: const Icon(Icons.share))
            ],
          ),
          body: _buildFileType(context, data)),
    );
  }

  Widget _buildFileType(BuildContext context, DocViewerDetailModel data) {
    if (data.fileType == DocViewerFileType.pdf) {
      return _buildPdf(context, data: data);
    } else if (data.fileType == DocViewerFileType.image) {
      return _buildImage(context, data: data);
    } else if (data.fileType == DocViewerFileType.video) {
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

  Widget _buildPdf(BuildContext context, {required DocViewerDetailModel data}) {
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
                      Expanded(
                        child: Text(
                          data.description,
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

  Widget _buildImage(BuildContext context,
      {required DocViewerDetailModel data}) {
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
        HtmlViewer(htmlString: data.description)
      ],
    );
  }

  Widget _buildVideo(BuildContext context,
      {required DocViewerDetailModel data}) {
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
        HtmlViewer(htmlString: data.description)
      ],
    );
  }
}
