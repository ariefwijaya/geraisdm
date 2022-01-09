import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/modules/register/blocs/register_bloc/register_bloc.dart';
import 'package:geraisdm/modules/register/blocs/register_config_bloc/register_config_bloc.dart';
import 'package:geraisdm/modules/register/models/register_config_model.dart';
import 'package:geraisdm/modules/register/models/register_form_model.dart';
import 'package:geraisdm/modules/register/screens/components/register_form_builder.dart';
import 'package:geraisdm/utils/helpers/time_helper.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/widgets/form_component.dart';
import 'package:geraisdm/widgets/general_component.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterScreen extends StatefulWidget {
  @queryParam
  final String? username;
  const RegisterScreen({Key? key, this.username}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, dynamic> formValues = {};
  RegisterFormModel formModel = RegisterFormModel();

  late RegisterConfigBloc registerConfigBloc;
  late RegisterBloc registerBloc;

  @override
  void initState() {
    super.initState();

    formValues = formModel.copyWith(username: widget.username).toJson();

    registerConfigBloc = getIt.get<RegisterConfigBloc>()
      ..add(RegisterConfigFetch());
    registerBloc = getIt.get<RegisterBloc>();
  }

  @override
  void dispose() {
    registerConfigBloc.close();
    registerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => registerConfigBloc,
        ),
        BlocProvider(
          create: (context) => registerBloc,
        )
      ],
      child: BlocBuilder<RegisterConfigBloc, RegisterConfigState>(
        bloc: registerConfigBloc,
        builder: (context, state) {
          if (state is RegisterConfigSuccess) {
            return _buildConfigSuccess(context, config: state.config);
          }

          if (state is RegisterConfigFailure) {
            return _buildConfigFailure();
          }

          return _buildConfigLoading();
        },
      ),
    );
  }

  Widget _buildConfigSuccess(BuildContext context,
      {required RegisterConfigModel config}) {
    return Scaffold(
      appBar: AppBar(
        leading: const AutoBackButton(),
      ),
      body: BlocConsumer<RegisterBloc, RegisterState>(
        bloc: registerBloc,
        listener: (context, state) {
          if (state is RegisterFailure) {
            FlushbarHelper.createError(
                    message: LocaleKeys.register_failure.tr())
                .show(context);
          }

          if (state is RegisterPhoneHasBeenUsed) {
            FlushbarHelper.createError(
                    message: LocaleKeys.register_phone_used.tr())
                .show(context);
          }

          if (state is RegisterNRPInvalid) {
            FlushbarHelper.createError(
                    message: LocaleKeys.register_nrp_invalid.tr())
                .show(context);
          }

          if (state is RegisterNIKInvalid) {
            FlushbarHelper.createError(
                    message: LocaleKeys.register_nik_invalid.tr())
                .show(context);
          }
          if (state is RegisterAlreadyRegistered) {
            FlushbarHelper.createAction(
                    button: NudeButton.small(
                        infiniteWidth: false,
                        buttonText:
                            LocaleKeys.register_already_registered_login.tr(),
                        onPressed: () {
                          context.replaceRoute(
                              LoginRoute(username: formModel.username));
                        }),
                    message: LocaleKeys.register_already_registered.tr())
                .show(context);
          }

          if (state is RegisterSuccess) {
            context.pushRoute(RegisterVerificationRoute(
                type: formModel.type,
                handphone: formModel.handphone,
                username: formModel.username,
                expiry: state.expiry,
                otpLength: state.otpLength));
          }
        },
        builder: (context, state) {
          final isLoading = state is RegisterLoading;
          if (formValues[config.verificationType.first.formId] == null) {
            formValues[config.verificationType.first.formId] =
                config.verificationTypeDefault;
          }

          return Form(
              key: _formKey,
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                children: [
                  Text(
                    LocaleKeys.register_title.tr(),
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 15),
                  ImagePlaceholder(
                    height: 150,
                    imageUrl: config.illustrationRegister,
                    imageFit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: config.verificationType
                        .where((element) => element.enabled)
                        .map((e) => Flexible(
                                child: Row(
                              children: [
                                Radio<String>(
                                  value: e.value,
                                  groupValue: formValues[e.formId],
                                  onChanged: e.readOnly
                                      ? null
                                      : (value) {
                                          setState(() {
                                            formValues[e.formId] = value;
                                          });
                                        },
                                  activeColor: Theme.of(context).primaryColor,
                                ),
                                Flexible(
                                  child: Text(
                                    e.nameKey.tr(),
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                )
                              ],
                            )))
                        .toList(),
                  ),
                  const SizedBox(height: 15),
                  Column(
                    children: config.verificationType
                        .firstWhere(
                          (element) =>
                              element.value ==
                                  formValues[
                                      config.verificationType.first.formId] &&
                              element.enabled,
                          orElse: () => config.verificationType.first,
                        )
                        .form
                        .map((e) {
                      if (e.type == RegisterConfigFormType.birthday) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: RegisterFormBuilder<
                              FormPickerFieldValue<DateTime>?>(
                            configForm: e,
                            isReadOnly: isLoading,
                            initialValue: formValues[e.formId] != null
                                ? FormPickerFieldValue(
                                    name: TimeHelper.dateTimeToYearMonthDay(
                                        DateTime.tryParse(
                                            formValues[e.formId])!,
                                        context.locale.languageCode),
                                    val:
                                        DateTime.tryParse(formValues[e.formId]))
                                : null,
                            onSaved: (value) {
                              formValues[e.formId] =
                                  TimeHelper.dateTimeToYearMonthDay(
                                      value!.val!, context.locale.languageCode);
                            },
                          ),
                        );
                      } else {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: RegisterFormBuilder<String?>(
                            configForm: e,
                            isReadOnly: isLoading,
                            initialValue: formValues[e.formId] as String?,
                            onSaved: (value) {
                              formValues[e.formId] = value;
                            },
                          ),
                        );
                      }
                    }).toList(),
                  ),
                  const SizedBox(height: 5),
                  FilledButton.large(
                      isLoading: isLoading,
                      buttonText: LocaleKeys.register_button.tr(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          formModel = RegisterFormModel.fromJson(formValues);
                          registerBloc.add(RegisterRequestOTP(
                              type: formModel.type!,
                              username: formModel.username!,
                              handphone: formModel.handphone!));
                        }
                      }),
                  const SizedBox(height: 5),
                  if (config.enableLogin)
                    NudeButton.large(
                        enabled: !isLoading,
                        infiniteWidth: false,
                        buttonText: LocaleKeys.register_login.tr(),
                        onPressed: () {
                          context.router.replace(
                              LoginRoute(username: formModel.username));
                        })
                ],
              ));
        },
      ),
    );
  }

  Widget _buildConfigFailure() {
    return Scaffold(
      appBar: AppBar(
        leading: const AutoBackButton(),
        title: Text(
          LocaleKeys.register_title.tr(),
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: CommonPlaceholder.noIcon(
          title: LocaleKeys.register_config_failed_title.tr(),
          subtitle: LocaleKeys.register_config_failed_subtitle.tr(),
          action: FilledButton.large(
              buttonText: LocaleKeys.register_config_failed_retry.tr(),
              onPressed: () => registerConfigBloc.add(RegisterConfigFetch()))),
    );
  }

  Widget _buildConfigLoading() {
    return Scaffold(
      appBar: AppBar(
        leading: const AutoBackButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        children: [
          Text(
            LocaleKeys.register_title.tr(),
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(height: 15),
          const SkeletonLoaderSquare(width: double.infinity, height: 200),
          const SizedBox(height: 20),
          Column(
            children: List.generate(
                2,
                (index) => Column(
                      children: const [
                        SkeletonLoaderSquare(
                            width: double.infinity, height: 14),
                        SizedBox(height: 8),
                        SkeletonLoaderSquare(
                            width: double.infinity, height: 42),
                        SizedBox(height: 15)
                      ],
                    )),
          ),
          const SizedBox(height: 15),
          const SkeletonLoaderSquare(width: double.infinity, height: 52)
        ],
      ),
    );
  }
}
