import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/modules/form_submission/blocs/form_selection_bloc/form_selection_bloc.dart';
import 'package:geraisdm/modules/form_submission/models/form_selection_model.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';

class FormSubmissionSelectionScreen extends StatelessWidget {
  final String apiUrl;
  final String title;
  final FormSelectionModel? initialValue;
  const FormSubmissionSelectionScreen(
      {Key? key, required this.apiUrl, required this.title, this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt.get<FormSelectionBloc>()..add(FormSelectionFetch(url: apiUrl)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: BlocBuilder<FormSelectionBloc, FormSelectionState>(
          builder: (context, state) {
            if (state is FormSelectionSuccess) {
              return ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    final data = state.data[index];
                    return Card(
                      child: ListTile(
                        title: Text(data.name),
                        onTap: () {
                          context.popRoute(data);
                        },
                      ),
                    );
                  });
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
                            .add(FormSelectionFetch(url: apiUrl));
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
