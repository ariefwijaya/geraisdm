import 'package:another_flushbar/flushbar_helper.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/core/settings/blocs/upload_file_bloc/upload_file_bloc.dart';
import 'package:geraisdm/core/settings/models/api_res_upload_model.dart';
import 'package:geraisdm/utils/helpers/launcher_helper.dart';
import 'package:geraisdm/widgets/alert_component.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';

class MultiUploadFilesField extends StatefulWidget {
  final String? label;
  final String? info;
  final bool readOnly;
  final List<ApiResUploadModel>? initialValues;
  final bool showDelete;
  final bool showAdd;
  final void Function(List<ApiResUploadModel> datas) onChanged;
  final int? maxFile;
  const MultiUploadFilesField(
      {Key? key,
      this.label,
      this.info,
      this.readOnly = false,
      this.initialValues,
      this.showAdd = true,
      this.showDelete = true,
      this.maxFile,
      required this.onChanged})
      : super(key: key);

  @override
  State<MultiUploadFilesField> createState() => _MultiUploadFilesFieldState();
}

class _MultiUploadFilesFieldState extends State<MultiUploadFilesField> {
  List<ApiResUploadModel> _files = [];
  late UploadFileBloc uploadFileBloc;

  @override
  void initState() {
    super.initState();
    if (widget.initialValues != null) {
      _files = widget.initialValues!;
    }
    //trigger onchanged for the first time
    widget.onChanged.call(_files);
    uploadFileBloc = getIt.get<UploadFileBloc>();
  }

  @override
  void dispose() {
    uploadFileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UploadFileBloc>(
      create: (context) => uploadFileBloc,
      child: BlocListener<UploadFileBloc, UploadFileState>(
        bloc: uploadFileBloc,
        listener: (context, state) {
          if (state is UploadFileSuccess) {
            setState(() {
              _files.add(state.data);
              widget.onChanged.call(_files);
            });
          }

          if (state is UploadFileFailed) {
            FlushbarHelper.createError(
                    message: LocaleKeys.form_upload_failed.tr())
                .show(context);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != null)
              Row(
                children: [
                  Text(
                    "${widget.label!} (${_files.length})",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  if (widget.info != null)
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          showRoundedModalBottomSheet(
                              context: context,
                              enableCloseButton: false,
                              builder: (context) => Container(
                                    margin: const EdgeInsets.all(16),
                                    child: Text(widget.info!),
                                  ));
                        },
                        child: const Icon(Icons.info),
                      ),
                    ))
                ],
              ),
            if (widget.label != null)
              const SizedBox(
                height: 12,
              ),
            Row(
              children: [
                if (widget.showAdd)
                  BlocBuilder<UploadFileBloc, UploadFileState>(
                    bloc: uploadFileBloc,
                    builder: (context, state) {
                      final isLoading = state is UploadFileLoading;
                      return Container(
                          margin: const EdgeInsets.only(
                              left: 16, top: 5, bottom: 5, right: 5),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .disabledColor
                                .withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          width: 90,
                          height: 90,
                          child: isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: widget.readOnly || !widget.showAdd
                                      ? null
                                      : () {
                                          if ((widget.maxFile != null &&
                                              _files.length >=
                                                  widget.maxFile!)) {
                                          } else {
                                            addFile();
                                          }
                                        },
                                  child: Icon(
                                    getPlaceholderIcon(),
                                    size: 30,
                                    color: Theme.of(context).disabledColor,
                                  ),
                                ));
                    },
                  )
                else
                  const SizedBox(width: 16),
                if (_files.isNotEmpty)
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(right: 16),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _files.mapIndexed<Widget>((index, foto) {
                          return _buildPreview(context, foto.uploadedFileUrl,
                              onDelete: widget.showDelete
                                  ? () {
                                      setState(() {
                                        _files.removeAt(index);
                                        widget.onChanged.call(_files);
                                      });
                                    }
                                  : null,
                              index: index);
                        }).toList(),
                      ),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreview(BuildContext context, String fileUrl,
      {VoidCallback? onDelete, required int index}) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Stack(
        children: [
          SizedBox(
            width: 90,
            height: 90,
            child: Hero(
              tag: "$index $fileUrl",
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    LauncherHelper.openUrl(fileUrl);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              Theme.of(context).disabledColor.withOpacity(0.3)),
                      color: Theme.of(context).disabledColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                        child: Text(
                      getFileExtension(fileUrl),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    )),
                  ),
                ),
              ),
            ),
          ),
          if (onDelete != null)
            Positioned(
                top: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color:
                          Theme.of(context).primaryColorLight.withOpacity(0.5),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(20))),
                  padding: const EdgeInsets.all(1),
                  child: CircleButton(
                    useOutline: true,
                    onPressed: onDelete,
                    child: const Icon(
                      Icons.close,
                      size: 16,
                    ),
                  ),
                ))
        ],
      ),
    );
  }

  String getFileExtension(String fileUrl) {
    final split = fileUrl.split('.');
    if (split.length > 1) {
      return "." + fileUrl.split('.').last;
    } else {
      return "File";
    }
  }

  IconData getPlaceholderIcon() {
    return Icons.add_box;
  }

  void addFile() {
    uploadFileBloc.add(UploadFileStarted());
  }
}
