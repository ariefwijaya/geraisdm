import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/modules/form_submission/blocs/form_selection_bloc/form_selection_bloc.dart';
import 'package:geraisdm/modules/form_submission/models/form_selection_model.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';

class FormSubmissionSelectionScreen extends StatefulWidget {
  final String apiUrl;
  final String title;
  final FormSelectionModel? initialValue;
  const FormSubmissionSelectionScreen(
      {Key? key, required this.apiUrl, required this.title, this.initialValue})
      : super(key: key);

  @override
  State<FormSubmissionSelectionScreen> createState() =>
      _FormSubmissionSelectionScreenState();
}

class _FormSubmissionSelectionScreenState
    extends State<FormSubmissionSelectionScreen> {
  late FormSelectionBloc formSelectionBloc;
  String? searchQuery;

  @override
  void initState() {
    super.initState();
    formSelectionBloc = getIt.get<FormSelectionBloc>()
      ..add(FormSelectionFetch(url: widget.apiUrl));
  }

  @override
  void dispose() {
    formSelectionBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => formSelectionBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: BlocBuilder<FormSelectionBloc, FormSelectionState>(
          builder: (context, state) {
            if (state is FormSelectionSuccess) {
              List<FormSelectionModel> filtered = state.data;
              if (searchQuery != null && searchQuery!.length > 2) {
                filtered = state.data
                    .where((element) => element.name
                        .toLowerCase()
                        .contains(searchQuery!.toLowerCase()))
                    .toList();
              }

              return Column(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CupertinoSearchTextField(
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                      )),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 2,
                            thickness: 3,
                            color: Theme.of(context)
                                .highlightColor
                                .withOpacity(0.2),
                          );
                        },
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final data = filtered[index];
                          return Card(
                            elevation: 0,
                            child: ListTile(
                              title: Text(data.name),
                              onTap: () {
                                context.popRoute(data);
                              },
                            ),
                          );
                        }),
                  ),
                ],
              );
            }

            if (state is FormSelectionFailure) {
              return CommonPlaceholder.error(
                  title: LocaleKeys.form_detail_error_title.tr(),
                  subtitle: LocaleKeys.form_detail_error_subtitle.tr(),
                  action: FilledButton.large(
                      buttonText: LocaleKeys.form_detail_error_retry.tr(),
                      onPressed: () {
                        context
                            .read<FormSelectionBloc>()
                            .add(FormSelectionFetch(url: widget.apiUrl));
                      }));
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
