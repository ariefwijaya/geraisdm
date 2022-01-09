import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:geraisdm/core/settings/blocs/countdown_timer/countdown_timer_cubit.dart';
import 'package:geraisdm/modules/register/blocs/register_activation_bloc/register_activation_bloc.dart';
import 'package:geraisdm/modules/register/blocs/register_bloc/register_bloc.dart';
import 'package:geraisdm/modules/register/blocs/register_config_bloc/register_config_bloc.dart';
import 'package:geraisdm/modules/register/models/register_config_model.dart';
import 'package:geraisdm/modules/register/models/register_form_model.dart';
import 'package:geraisdm/modules/register/screens/components/register_form_builder.dart';
import 'package:geraisdm/modules/register/screens/components/register_success_fragment.dart';
import 'package:geraisdm/utils/helpers/time_helper.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/widgets/form_component.dart';
import 'package:geraisdm/widgets/general_component.dart';

class RegisterVerificationScreen extends StatefulWidget {
  @queryParam
  final String? type;
  @queryParam
  final String? username;
  @queryParam
  final String? handphone;
  @QueryParam("otp_length")
  final int? otpLength;
  @QueryParam("expiry")
  final int? expiry;
  const RegisterVerificationScreen(
      {Key? key,
      this.type,
      this.username,
      this.handphone,
      this.expiry,
      this.otpLength})
      : super(key: key);

  @override
  State<RegisterVerificationScreen> createState() =>
      _RegisterVerificationScreenState();
}

class _RegisterVerificationScreenState
    extends State<RegisterVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? otp;
  int? otpLength;

  Map<String, dynamic> formValues = {};
  RegisterFormModel formModel = RegisterFormModel();

  late RegisterConfigBloc registerConfigBloc;
  late RegisterBloc registerBloc;
  late RegisterActivationBloc registerActivationBloc;
  late CountdownTimerCubit countdownTimerCubit;

  @override
  void initState() {
    super.initState();

    formValues = formModel
        .copyWith(
            type: widget.type,
            username: widget.username,
            handphone: widget.handphone)
        .toJson();

    otpLength = widget.otpLength;

    registerConfigBloc = getIt.get<RegisterConfigBloc>()
      ..add(RegisterConfigFetch());
    registerBloc = getIt.get<RegisterBloc>();
    registerActivationBloc = getIt.get<RegisterActivationBloc>();
    countdownTimerCubit = getIt.get<CountdownTimerCubit>()
      ..startTimer(start: widget.expiry!);
  }

  @override
  void dispose() {
    registerConfigBloc.close();
    registerBloc.close();
    registerActivationBloc.close();
    countdownTimerCubit.close();
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
            create: (context) => registerActivationBloc,
          ),
          BlocProvider(create: (context) => countdownTimerCubit),
          BlocProvider(create: (context) => registerBloc)
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
        ));
  }

  Widget _buildConfigSuccess(BuildContext context,
      {required RegisterConfigModel config}) {
    return Scaffold(
      appBar: AppBar(
        leading: const AutoBackButton(),
        title: Text(LocaleKeys.register_activation_title.tr()),
      ),
      body: BlocListener<RegisterBloc, RegisterState>(
        bloc: registerBloc,
        listener: (context, registerState) {
          if (registerState is RegisterSuccess) {
            countdownTimerCubit.startTimer(start: registerState.expiry);
            setState(() {
              otpLength = registerState.otpLength;
            });
          }

          if (registerState is RegisterFailure) {
            FlushbarHelper.createError(
                    message: LocaleKeys.register_failure.tr())
                .show(context);
          }

          if (registerState is RegisterPhoneHasBeenUsed) {
            FlushbarHelper.createError(
                    message: LocaleKeys.register_phone_used.tr())
                .show(context);
          }

          if (registerState is RegisterNRPInvalid) {
            FlushbarHelper.createError(
                    message: LocaleKeys.register_nrp_invalid.tr())
                .show(context);
          }

          if (registerState is RegisterNIKInvalid) {
            FlushbarHelper.createError(
                    message: LocaleKeys.register_nik_invalid.tr())
                .show(context);
          }
          if (registerState is RegisterAlreadyRegistered) {
            FlushbarHelper.createAction(
                    button: NudeButton.small(
                        infiniteWidth: false,
                        buttonText:
                            LocaleKeys.register_already_registered_login.tr(),
                        onPressed: () {
                          context.router.popUntilRoot();
                          context.pushRoute(LoginRoute());
                        }),
                    message: LocaleKeys.register_already_registered.tr())
                .show(context);
          }
        },
        child: BlocConsumer<RegisterActivationBloc, RegisterActivationState>(
          bloc: registerActivationBloc,
          listener: (context, state) {
            if (state is RegisterActivationSuccess) {
              context.router.root.popUntilRoot();
              context.router.root.pushWidget(const RegisterSuccessFragment());
            }

            if (state is RegisterActivationOTPWrong) {
              FlushbarHelper.createError(
                      message: LocaleKeys.register_activation_otp_wrong.tr())
                  .show(context);
            }

            if (state is RegisterActivationOTPExpired) {
              FlushbarHelper.createError(
                      message: LocaleKeys.register_activation_otp_expired.tr())
                  .show(context);
            }

            if (state is RegisterActivationBadRequest) {
              FlushbarHelper.createError(
                      message: LocaleKeys.register_activation_bad_request.tr())
                  .show(context);
            }

            if (state is RegisterActivationBirthdayWrong) {
              FlushbarHelper.createError(
                      message:
                          LocaleKeys.register_activation_birthday_wrong.tr())
                  .show(context);
            }

            if (state is RegisterActivationFailure) {
              FlushbarHelper.createError(
                      message: LocaleKeys.register_activation_failure.tr())
                  .show(context);
            }
          },
          builder: (context, state) {
            final isLoading = state is RegisterActivationLoading;
            return Form(
                key: _formKey,
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  children: [
                    Row(
                      children: config.registerType
                          .where((element) => element.enabled)
                          .map((e) => Flexible(
                                  child: Row(
                                children: [
                                  Radio<String>(
                                    value: e.value,
                                    groupValue: widget.type,
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
                      children: config.registerType
                          .firstWhere(
                            (element) =>
                                element.value ==
                                    formValues[
                                        config.registerType.first.formId] &&
                                element.enabled,
                            orElse: () => config.registerType.first,
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
                                      val: DateTime.tryParse(
                                          formValues[e.formId]))
                                  : null,
                              onSaved: (value) {
                                formValues[e.formId] =
                                    TimeHelper.dateTimeToYearMonthDay(
                                        value!.val!,
                                        context.locale.languageCode);
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
                    FilledPinTextField(
                        enablePinAutofill: false,
                        label: LocaleKeys.register_otp_title.tr(),
                        onChanged: (value) {
                          otp = value;
                        },
                        readOnly: isLoading,
                        validator: RequiredValidator(
                            errorText: LocaleKeys.register_form_required.tr()),
                        onSaved: (value) {
                          otp = value;
                        },
                        length: otpLength!),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        MarkdownBody(
                          data: LocaleKeys.register_otp_description.tr(args: [
                            otpLength.toString(),
                            widget.handphone.toString()
                          ]),
                        ),
                        const SizedBox(height: 5),
                        _buildCountdownResend(isLoading: isLoading)
                      ],
                    ),
                    const SizedBox(height: 15),
                    FilledButton.large(
                        isLoading: isLoading,
                        buttonText: LocaleKeys.register_activation_button.tr(),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            formModel = RegisterFormModel.fromJson(formValues);
                            registerActivationBloc.add(RegisterActivationStart(
                                otp: otp!, data: formModel));
                          }
                        }),
                    const SizedBox(height: 20),
                  ],
                ));
          },
        ),
      ),
    );
  }

  Widget _buildConfigFailure() {
    return Scaffold(
      appBar: AppBar(
        leading: const AutoBackButton(),
        title: Text(LocaleKeys.register_activation_title.tr()),
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
        title: Text(LocaleKeys.register_activation_title.tr()),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        children: [
          Row(children: const [
            Expanded(
              child: SkeletonLoaderSquare(width: double.infinity, height: 24),
            ),
            SizedBox(width: 20),
            Expanded(
              child: SkeletonLoaderSquare(width: double.infinity, height: 24),
            ),
          ]),
          const SizedBox(height: 20),
          Column(
            children: List.generate(
                5,
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
          const SizedBox(height: 5),
          const SkeletonLoaderSquare(width: double.infinity, height: 52)
        ],
      ),
    );
  }

  Widget _buildCountdownResend({bool isLoading = false}) {
    return BlocBuilder<CountdownTimerCubit, CountdownTimerState>(
      bloc: countdownTimerCubit,
      builder: (context, state) {
        if (state.seconds > 0) {
          return MarkdownBody(
            data: LocaleKeys.register_verification
                .tr(args: [(state.durationFormat)]),
            styleSheet: MarkdownStyleSheet(
                p: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 12),
                strong: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.headline1!.color)),
          );
        }

        return Row(
          children: [
            Expanded(
              child: Text(
                LocaleKeys.register_verification_pending.tr(),
                style: const TextStyle(fontSize: 12),
              ),
            ),
            NudeButton.small(
                infiniteWidth: false,
                enabled: !isLoading,
                buttonText: LocaleKeys.register_verification_resend.tr(),
                onPressed: () {
                  registerBloc.add(RegisterRequestOTP(
                      type: widget.type!,
                      handphone: widget.handphone!,
                      username: widget.username!));
                })
          ],
        );
      },
    );
  }
}
