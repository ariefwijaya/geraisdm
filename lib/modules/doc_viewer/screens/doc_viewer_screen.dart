import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/modules/doc_viewer/blocs/doc_viewer_bloc/doc_viewer_bloc.dart';
import 'package:geraisdm/modules/doc_viewer/models/doc_viewer_model.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/constant/assets.gen.dart';

class DocViewerScreen extends StatelessWidget {
  final int id;
  final String? title;
  final String? type;
  const DocViewerScreen(
      {Key? key,
      @pathParam required this.id,
      @queryParam this.title,
      @queryParam this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt.get<DocViewerBloc>()..add(DocViewerFetch(id: id, type: type)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title ?? ""),
        ),
        body: BlocBuilder<DocViewerBloc, DocViewerState>(
          builder: (context, state) {
            if (state is DocViewerSuccess) {
              if (state.data.isEmpty) {
                return _buildNotFound();
              }
              return _buildSuccess(context, listData: state.data);
            }
            if (state is DocViewerFailure) {
              return _buildFailure(context);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildNotFound() {
    return Container(
      margin: const EdgeInsets.all(24),
      child: CommonPlaceholder.noIcon(
        title: LocaleKeys.doc_viewer_nodata_title.tr(),
        subtitle: LocaleKeys.doc_viewer_nodata_subtitle.tr(),
      ),
    );
  }

  Widget _buildFailure(BuildContext context) {
    return CommonPlaceholder.customIcon(
        icon: Assets.images.illustration.warningCyt.image(height: 200),
        title: LocaleKeys.doc_viewer_error_title.tr(),
        subtitle: LocaleKeys.doc_viewer_error_subtitle.tr(),
        action: FilledButton.large(
            buttonText: LocaleKeys.doc_viewer_error_retry.tr(),
            onPressed: () {
              context.read<DocViewerBloc>().add(DocViewerFetch(id: id));
            }));
  }

  Widget _buildSuccess(BuildContext context,
      {required List<DocViewerModel> listData}) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: listData.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16);
      },
      itemBuilder: (context, index) {
        final data = listData[index];
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 8,
          shadowColor: Theme.of(context).shadowColor.withOpacity(0.5),
          child: ListTile(
            leading: const Icon(Icons.document_scanner),
            title: Text(data.name),
            subtitle: Text(DateFormat("d MMM yyyy, hh:mm").format(data.date)),
            onTap: () {
              context.pushRoute(
                  DocViewerDetailRoute(id: data.id, title: data.name));
            },
          ),
        );
      },
    );
  }
}
