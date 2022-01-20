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
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DocViewerDetailScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<DocViewerDetailBloc>()
        ..add(DocViewerDetailFetch(id: id, type: type)),
      child: BlocBuilder<DocViewerDetailBloc, DocViewerDetailState>(
        builder: (context, state) {
          if (state is DocViewerDetailSuccess) {
            return _buildSuccess(context, data: state.data);
          }

          if (state is DocViewerDetailFailure) {
            return _buildFailure(context);
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(title ?? ""),
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
        title: Text(title ?? ""),
      ),
      body: CommonPlaceholder.customIcon(
          icon: Assets.images.illustration.warningCyt.image(height: 200),
          title: LocaleKeys.doc_viewer_error_title.tr(),
          subtitle: LocaleKeys.doc_viewer_error_subtitle.tr(),
          action: FilledButton.large(
              buttonText: LocaleKeys.doc_viewer_error_retry.tr(),
              onPressed: () {
                context
                    .read<DocViewerDetailBloc>()
                    .add(DocViewerDetailFetch(id: id));
              })),
    );
  }

  Widget _buildSuccess(BuildContext context,
      {required DocViewerDetailModel data}) {
    final PageController pageController = PageController(keepPage: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? ""),
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
      body: PageView.builder(
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
                )),
              ],
            ),
          );
        },
      ),
    );
  }
}
