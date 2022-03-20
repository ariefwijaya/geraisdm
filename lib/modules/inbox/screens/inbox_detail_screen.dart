import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/modules/inbox/blocs/inbox_bloc/inbox_bloc.dart';
import 'package:geraisdm/modules/inbox/blocs/inbox_send_bloc/inbox_send_bloc.dart';
import 'package:geraisdm/modules/inbox/models/inbox_detail_model.dart';
import 'package:geraisdm/modules/inbox/models/inbox_model.dart';
import 'package:geraisdm/utils/helpers/format_helper.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/constant/assets.gen.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/widgets/form_component.dart';

class InboxDetailScreen extends StatefulWidget {
  final int id;
  final String? title;
  const InboxDetailScreen({Key? key, @pathParam required this.id, this.title})
      : super(key: key);

  @override
  State<InboxDetailScreen> createState() => _InboxDetailScreenState();
}

class _InboxDetailScreenState extends State<InboxDetailScreen> {
  late InboxBloc inboxBloc;
  late InboxSendBloc inboxSendBloc;
  TextEditingController messageText = TextEditingController();
  List<InboxDetailModel> messages = [];

  @override
  void initState() {
    inboxBloc = getIt.get<InboxBloc>()..add(InboxFetchDetail(id: widget.id));
    inboxSendBloc = getIt.get<InboxSendBloc>();
    super.initState();
  }

  @override
  void dispose() {
    inboxBloc.close();
    inboxSendBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => inboxBloc),
        BlocProvider(create: (context) => inboxSendBloc)
      ],
      child: BlocBuilder<InboxBloc, InboxState>(
        bloc: inboxBloc,
        builder: (context, state) {
          if (state is InboxSuccess) {
            return _buildSuccess(context, listData: state.data);
          }
          if (state is InboxFailure) {
            return _buildFailure();
          }
          return Scaffold(
              appBar: AppBar(
                title: Text(widget.title ?? ""),
              ),
              body: const Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }

  Widget _buildFailure() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ""),
      ),
      body: CommonPlaceholder.customIcon(
          icon: Assets.images.illustration.warningCyt.image(height: 200),
          title: LocaleKeys.inbox_error_title.tr(),
          subtitle: LocaleKeys.inbox_error_subtitle.tr(),
          action: FilledButton.large(
              buttonText: LocaleKeys.inbox_error_retry.tr(),
              onPressed: () {
                inboxBloc.add(InboxFetchDetail(id: widget.id));
              })),
    );
  }

  Widget _buildSuccess(BuildContext context,
      {required List<InboxDetailModel> listData}) {
    if (messages.isEmpty) {
      messages = listData;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ""),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocConsumer<InboxSendBloc, InboxSendState>(
              bloc: inboxSendBloc,
              listener: (context, state) {
                if (state is InboxSendFailure) {
                  FlushbarHelper.createError(
                          message: LocaleKeys.inbox_error_subtitle.tr())
                      .show(context);
                }
                if (state is InboxSendSuccess) {
                  setState(() {
                    messages.add(InboxDetailModel(
                        id: 0,
                        message: state.message,
                        createdDate: DateTime.now(),
                        status: InboxStatus.read,
                        type: InboxUserType.user));
                  });
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
                        hint: LocaleKeys.inbox_send_hint.tr(),
                      )),
                      const SizedBox(width: 8),
                      if (state is InboxSendLoading)
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
                              inboxSendBloc.add(InboxSendMessageStart(
                                  id: widget.id, message: messageText.text));
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
      body: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          itemBuilder: (context, index) {
            final data = messages[index];

            final childrens = [
              Expanded(
                child: Column(
                  crossAxisAlignment: data.type == InboxUserType.user
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                          FormatHelper.enumName(data.type).toUpperCase(),
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    Card(
                      elevation: 0,
                      color: data.type == InboxUserType.admin
                          ? Theme.of(context).primaryColor.withOpacity(0.04)
                          : Theme.of(context).scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                          side: BorderSide(
                              color: Theme.of(context)
                                  .highlightColor
                                  .withOpacity(0.2),
                              width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.message,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    DateFormat(
                                      "d MMMM yyyy, hh:mm",
                                    ).format(data.createdDate),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(width: 8),
                                  data.status == InboxStatus.delivered
                                      ? const Icon(Icons.check,
                                          color: Colors.green)
                                      : data.status == InboxStatus.read
                                          ? const Icon(
                                              Icons.checklist_sharp,
                                            )
                                          : const Icon(Icons.device_unknown)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 50,
              )
            ];
            return Row(
              children: data.type == InboxUserType.user
                  ? childrens.reversed.toList()
                  : childrens.toList(),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8);
          },
          itemCount: messages.length),
    );
  }
}
