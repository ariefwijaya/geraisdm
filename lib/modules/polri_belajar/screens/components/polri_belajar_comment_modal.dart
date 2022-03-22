import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/modules/polri_belajar/blocs/polri_belajar_comment_bloc/polri_belajar_comment_bloc.dart';
import 'package:geraisdm/modules/polri_belajar/blocs/polri_belajar_comment_submit_bloc/polri_belajar_comment_submit_bloc.dart';
import 'package:geraisdm/modules/polri_belajar/models/polri_belajar_comment_model.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/widgets/form_component.dart';

class PolriBelajarCommentModal extends StatelessWidget {
  final int id;
  final int refId;
  final String? title;
  const PolriBelajarCommentModal(
      {Key? key, required this.id, required this.refId, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => getIt.get<PolriBelajarCommentBloc>()
              ..add(PolriBelajarCommentFetch(id: id, refId: refId))),
        BlocProvider(
            create: (context) => getIt.get<PolriBelajarCommentSubmitBloc>()),
      ],
      child: BlocBuilder<PolriBelajarCommentBloc, PolriBelajarCommentState>(
        builder: (context, state) {
          if (state is PolriBelajarCommentSuccess) {
            return _buildSuccess(context, comments: state.data);
          }

          if (state is PolriBelajarCommentFailure) {
            return _buildError(context);
          }
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: CommonPlaceholder.error(
            title: LocaleKeys.polri_belajar_comment_error_title.tr(),
            subtitle: LocaleKeys.polri_belajar_comment_error_subtitle.tr(),
            action: FilledButton.large(
                buttonText: LocaleKeys.polri_belajar_comment_error_retry.tr(),
                onPressed: () {
                  context
                      .read<PolriBelajarCommentBloc>()
                      .add(PolriBelajarCommentFetch(id: id, refId: refId));
                })),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context,
      {required List<PolriBelajarCommentModel> comments}) {
    TextEditingController messageText = TextEditingController();
    final ScrollController _scrollController = ScrollController();
    List<PolriBelajarCommentModel> allcomments = comments;

    return StatefulBuilder(builder: (context, innerSetState) {
      return Scaffold(
        appBar: AppBar(
          title: title != null ? Text(title!) : null,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocConsumer<PolriBelajarCommentSubmitBloc,
                  PolriBelajarCommentSubmitState>(
                listener: (context, state) {
                  if (state is PolriBelajarCommentSubmitFailure) {
                    FlushbarHelper.createError(
                            message: LocaleKeys
                                .polri_belajar_comment_submit_fail
                                .tr())
                        .show(context);
                  }
                  if (state is PolriBelajarCommentSubmitSuccess) {
                    FlushbarHelper.createSuccess(
                            message: LocaleKeys
                                .polri_belajar_comment_submit_success
                                .tr())
                        .show(context);
                    innerSetState(() {
                      allcomments.add(state.data);
                    });
                    _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent + 100,
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 300));
                  }
                },
                builder: (context, state) {
                  return Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Row(
                      children: [
                        Expanded(
                            child: FilledTextField(
                          maxLines: null,
                          controller: messageText,
                          hint:
                              LocaleKeys.polri_belajar_comment_placeholder.tr(),
                        )),
                        const SizedBox(width: 8),
                        if (state is PolriBelajarCommentSubmitLoading)
                          const SizedBox(
                            width: 35,
                            height: 35,
                            child: CircularProgressIndicator(),
                          )
                        else
                          CircleButton(
                            outlineColor: Theme.of(context).primaryColor,
                            useOutline: true,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.send,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            onPressed: () {
                              if (messageText.text.isEmpty) {
                                FlushbarHelper.createError(
                                        message: LocaleKeys.form_required.tr())
                                    .show(context);
                              } else {
                                context
                                    .read<PolriBelajarCommentSubmitBloc>()
                                    .add(PolriBelajarCommentSubmit(
                                        id: id,
                                        refId: refId,
                                        comment: messageText.text));
                                messageText.clear();
                              }
                            },
                          ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
        body: allcomments.isEmpty
            ? Center(
                child: Text(LocaleKeys.polri_belajar_comment_submit_empty.tr()),
              )
            : ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = allcomments[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ImagePlaceholder(
                            imageUrl: item.avatar,
                            height: 35,
                            width: 35,
                            shape: BoxShape.circle,
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Text(item.userName,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.headline5),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              DateFormat(
                                "d MMMM yyyy, hh:mm",
                              ).format(item.date),
                              textAlign: TextAlign.right,
                              style: const TextStyle(fontSize: 10),
                            ),
                          )
                        ],
                      ),
                      Card(
                        elevation: 0,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                            side: BorderSide(
                                color: Theme.of(context)
                                    .highlightColor
                                    .withOpacity(0.2),
                                width: 2)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            item.comment,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemCount: allcomments.length),
      );
    });
  }
}
