import 'dart:convert';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/core/settings/models/api_res_upload_model.dart';
import 'package:geraisdm/modules/form_submission/blocs/form_submission_bloc/form_submission_bloc.dart';
import 'package:geraisdm/modules/form_submission/blocs/form_submission_submit_bloc/form_submission_submit_bloc.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/modules/form_submission/models/form_selection_model.dart';
import 'package:geraisdm/modules/form_submission/models/form_submission_model.dart';
import 'package:geraisdm/modules/form_submission/screens/form_submission_selection_screen.dart';
import 'package:geraisdm/utils/helpers/time_helper.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/constant/assets.gen.dart';
import 'package:geraisdm/widgets/form_component.dart';
import 'package:geraisdm/widgets/form_multi_upload.dart';

class FormSubmissionScreen extends StatefulWidget {
  final int id;
  const FormSubmissionScreen({Key? key, @pathParam required this.id})
      : super(key: key);

  @override
  State<FormSubmissionScreen> createState() => _FormSubmissionScreenState();
}

class _FormSubmissionScreenState extends State<FormSubmissionScreen> {
  late FormSubmissionBloc formSubmissionBloc;
  late FormSubmissionSubmitBloc formSubmissionSubmitBloc;
  final Map<String, dynamic> valueMapper = {};
  final Map<String, dynamic> valueObjectMapper = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> uploadFileKeyRequired = [];

  @override
  void initState() {
    formSubmissionBloc = getIt.get<FormSubmissionBloc>()
      ..add(FormSubmissionFetch(id: widget.id));
    formSubmissionSubmitBloc = getIt.get<FormSubmissionSubmitBloc>();
    super.initState();
  }

  @override
  void dispose() {
    formSubmissionBloc.close();
    formSubmissionSubmitBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => formSubmissionBloc),
          BlocProvider(create: (context) => formSubmissionSubmitBloc)
        ],
        child: BlocBuilder<FormSubmissionBloc, FormSubmissionState>(
          builder: (context, state) {
            if (state is FormSubmissionSuccess) {
              return _buildSuccess(context, data: state.data);
            }

            if (state is FormSubmissionFailure) {
              return _buildFailure(context);
            }
            return _buildLoading();
          },
        ));
  }

  Widget _buildFailure(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const RouteBackButton(),
        title: Text(LocaleKeys.form_submit_title.tr()),
      ),
      body: CommonPlaceholder.customIcon(
          icon: Assets.images.illustration.warningCyt.image(height: 200),
          title: LocaleKeys.form_detail_error_title.tr(),
          subtitle: LocaleKeys.form_detail_error_subtitle.tr(),
          action: FilledButton.large(
              buttonText: LocaleKeys.form_detail_error_retry.tr(),
              onPressed: () {
                context
                    .read<FormSubmissionBloc>()
                    .add(FormSubmissionFetch(id: widget.id));
              })),
    );
  }

  Widget _buildLoading() {
    return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.form_submit_title.tr()),
        ),
        body: const Center(child: CircularProgressIndicator()));
  }

  Widget _buildSuccess(BuildContext context,
      {required FormSubmissionModel data}) {
    return BlocConsumer<FormSubmissionSubmitBloc, FormSubmissionSubmitState>(
      bloc: formSubmissionSubmitBloc,
      listener: (context, state) {
        if (state is FormSubmissionSubmitFailure) {
          FlushbarHelper.createError(
                  message: LocaleKeys.form_submit_failure.tr())
              .show(context);
        }

        if (state is FormSubmissionSubmitSuccess) {
          FlushbarHelper.createSuccess(
                  message: LocaleKeys.form_submit_success.tr())
              .show(context)
              .then((value) {
            context.navigateTo(const HomeLayoutRoute());
          });
        }
      },
      builder: (context, state) {
        final isLoading = state is FormSubmissionSubmitLoading;
        return Scaffold(
          appBar: AppBar(
            title: Text(data.title),
          ),
          bottomNavigationBar: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FilledButton.large(
                    isLoading: isLoading,
                    buttonText: LocaleKeys.form_submit_button.tr(),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        int requiredValidation = 0;
                        for (final item in uploadFileKeyRequired) {
                          if (valueMapper[item] == null ||
                              valueMapper[item] == "") {
                            requiredValidation++;
                            FlushbarHelper.createError(
                                    message:
                                        LocaleKeys.form_upload_required.tr())
                                .show(context);
                            break;
                          }
                        }

                        if (requiredValidation == 0) {
                          formSubmissionSubmitBloc.add(
                              FormSubmissionSubmitStart(
                                  form: valueMapper, id: widget.id));
                        }
                      }
                    })
              ],
            ),
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    children: data.forms
                        .map((e) {
                          switch (e.type) {
                            case FormSubmissionFieldType.text:
                              return FilledTextField(
                                hint: e.hint ?? "",
                                readOnly: e.readonly,
                                enabled: e.enabled,
                                initialValue: e.initialValue,
                                label: e.title,
                                validator: MultiValidator([
                                  if (e.required)
                                    RequiredValidator(
                                        errorText:
                                            LocaleKeys.form_required.tr())
                                ]),
                                onSaved: (value) {
                                  valueMapper[e.valueName] = value;
                                },
                              );

                            case FormSubmissionFieldType.email:
                              return FilledTextField(
                                hint: e.hint ?? "",
                                readOnly: e.readonly,
                                enabled: e.enabled,
                                initialValue: e.initialValue,
                                label: e.title,
                                validator: MultiValidator([
                                  if (e.required)
                                    RequiredValidator(
                                        errorText:
                                            LocaleKeys.form_required.tr()),
                                  EmailValidator(
                                      errorText:
                                          LocaleKeys.form_email_invalid.tr())
                                ]),
                                onSaved: (value) {
                                  valueMapper[e.valueName] = value;
                                },
                              );
                            case FormSubmissionFieldType.password:
                              return FilledPasswordTextField(
                                hint: e.hint ?? "",
                                readOnly: e.readonly,
                                enabled: e.enabled,
                                initialValue: e.initialValue,
                                label: e.title,
                                validator: MultiValidator([
                                  if (e.required)
                                    RequiredValidator(
                                        errorText:
                                            LocaleKeys.form_required.tr())
                                ]),
                                onSaved: (value) {
                                  valueMapper[e.valueName] = value;
                                },
                              );
                            case FormSubmissionFieldType.textarea:
                              return FilledTextField(
                                maxLines: 4,
                                hint: e.hint ?? "",
                                readOnly: e.readonly,
                                enabled: e.enabled,
                                initialValue: e.initialValue,
                                label: e.title,
                                validator: MultiValidator([
                                  if (e.required)
                                    RequiredValidator(
                                        errorText:
                                            LocaleKeys.form_required.tr())
                                ]),
                                onSaved: (value) {
                                  valueMapper[e.valueName] = value;
                                },
                              );

                            case FormSubmissionFieldType.select:
                              return GhostDropdownTextField<FormSelectionModel>(
                                hint: e.hint ?? "",
                                readOnly: e.readonly,
                                value: valueObjectMapper[e.valueName],
                                label: e.title,
                                items:
                                    (jsonDecode(e.argument!) as List<dynamic>)
                                        .map((e) {
                                  final el = FormSelectionModel.fromJson(
                                      e as Map<String, dynamic>);
                                  return DropdownMenuItem<FormSelectionModel>(
                                    child: Text(el.name),
                                    value: el,
                                  );
                                }).toList(),
                                validator: (value) {
                                  if (e.required) {
                                    final valid = RequiredValidator(
                                            errorText:
                                                LocaleKeys.form_required.tr())
                                        .call(value?.name ?? "");
                                    if (valid != null) {
                                      return valid;
                                    } else {
                                      return null;
                                    }
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  valueMapper[e.valueName] = value?.value;
                                  valueObjectMapper[e.valueName] = value;
                                },
                                onSaved: (value) {
                                  valueMapper[e.valueName] = value?.value;
                                  valueObjectMapper[e.valueName] = value;
                                },
                              );

                            case FormSubmissionFieldType.selectApi:
                              return FilledPickerField<FormSelectionModel>(
                                hint: e.hint ?? "",
                                label: e.title,
                                initialValue: e.initialValue != null
                                    ? FormPickerFieldValue(
                                        name: e.initialValue!,
                                        val: FormSelectionModel.fromJson(
                                            jsonDecode(e.initialValue!)))
                                    : null,
                                validator: (val) {
                                  if (e.required) {
                                    final valid = RequiredValidator(
                                            errorText:
                                                LocaleKeys.form_required.tr())
                                        .call(val?.name ?? "");
                                    if (valid != null) {
                                      return FormPickerFieldValue(name: valid);
                                    } else {
                                      return null;
                                    }
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  valueMapper[e.valueName] = value?.val?.value;
                                  valueObjectMapper[e.valueName] = value?.val;
                                },
                                onTap: (val) async {
                                  final selected = await context.router
                                      .pushWidget<FormSelectionModel?>(
                                          FormSubmissionSelectionScreen(
                                    title: e.title,
                                    apiUrl: e.argument!,
                                    initialValue:
                                        valueObjectMapper[e.valueName],
                                  ));
                                  if (selected != null) {
                                    return FormPickerFieldValue(
                                        name: selected.name, val: selected);
                                  }
                                },
                              );

                            case FormSubmissionFieldType.uploadFile:
                              if (e.required) {
                                uploadFileKeyRequired.removeWhere(
                                    (element) => element == e.valueName);
                                uploadFileKeyRequired.add(e.valueName);
                              }
                              return MultiUploadFilesField(
                                maxFile: 1,
                                id: widget.id.toString(),
                                info: e.hint,
                                label: e.title,
                                readOnly: e.readonly,
                                initialValues: e.initialValue != null
                                    ? (jsonDecode(e.initialValue!)
                                            as List<dynamic>)
                                        .map((s) => ApiResUploadModel.fromJson(
                                            s as Map<String, dynamic>))
                                        .toList()
                                    : null,
                                onChanged: (value) {
                                  valueMapper[e.valueName] = value
                                      .map((s) => s.uploadedFile)
                                      .toList()
                                      .join(",");
                                  valueObjectMapper[e.valueName] = value;
                                },
                              );

                            case FormSubmissionFieldType.date:
                              return FilledPickerField<DateTime>(
                                initialValue: e.initialValue != null
                                    ? FormPickerFieldValue(
                                        name: TimeHelper.dateTimeToYearMonthDay(
                                            DateTime.tryParse(e.initialValue!)!,
                                            context.locale.languageCode),
                                        val: DateTime.tryParse(e.initialValue!))
                                    : null,
                                suffixIcon: Icons.calendar_today,
                                hint: e.hint ?? "",
                                label: e.title,
                                validator: (val) {
                                  if (!e.required) return null;
                                  final valid = RequiredValidator(
                                          errorText:
                                              LocaleKeys.form_required.tr())
                                      .call(val?.name ?? "");
                                  if (valid != null) {
                                    return FormPickerFieldValue(name: valid);
                                  } else {
                                    return null;
                                  }
                                },
                                onTap: e.readonly
                                    ? null
                                    : (val) async {
                                        final selected = await showDatePicker(
                                            context: context,
                                            initialDate:
                                                (val)?.val ?? DateTime.now(),
                                            firstDate: DateTime(1945),
                                            lastDate: DateTime.now());

                                        if (selected != null) {
                                          return FormPickerFieldValue(
                                              name: TimeHelper
                                                  .dateTimeToDayMonthYear(
                                                      selected,
                                                      context
                                                          .locale.languageCode),
                                              val: selected);
                                        }
                                      },
                                onSaved: (value) {
                                  if (value?.val != null) {
                                    TimeHelper.dateTimeToYearMonthDay(
                                        value!.val!);
                                  }
                                  valueMapper[e.valueName] =
                                      TimeHelper.dateTimeToYearMonthDay(
                                          value!.val!);
                                  valueObjectMapper[e.valueName] =
                                      TimeHelper.dateTimeToYearMonthDay(
                                          value.val!);
                                },
                              );

                            default:
                              return Container();
                          }
                        })
                        .map((e) =>
                            Column(children: [e, const SizedBox(height: 16)]))
                        .toList()),
              ),
            ),
          ),
        );
      },
    );
  }
}
