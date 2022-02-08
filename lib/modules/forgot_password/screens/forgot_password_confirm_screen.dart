import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/modules/forgot_password/blocs/forgot_password_confirm_bloc/forgot_password_confirm_bloc.dart';
import 'package:geraisdm/modules/forgot_password/models/forgot_password_form_model.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/widgets/form_component.dart';

class ForgotPasswordConfirmScreen extends StatefulWidget {
  final String? username;
  final int? expiry;
  final int? otpLength;
  const ForgotPasswordConfirmScreen(
      {Key? key,
      @queryParam this.username,
      @queryParam this.expiry,
      @queryParam this.otpLength})
      : super(key: key);

  @override
  State<ForgotPasswordConfirmScreen> createState() =>
      _ForgotPasswordConfirmScreenState();
}

class _ForgotPasswordConfirmScreenState
    extends State<ForgotPasswordConfirmScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? otp;
  String? newPassword;
  late ForgotPasswordConfirmBloc forgotPasswordConfirmBloc;

  @override
  void initState() {
    forgotPasswordConfirmBloc = getIt.get<ForgotPasswordConfirmBloc>();
    super.initState();
  }

  @override
  void dispose() {
    forgotPasswordConfirmBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => forgotPasswordConfirmBloc,
      child: Scaffold(
        appBar: AppBar(
          leading: const RouteBackButton(),
          title: Text(LocaleKeys.forgot_password_confirmation_title.tr()),
        ),
        body:
            BlocConsumer<ForgotPasswordConfirmBloc, ForgotPasswordConfirmState>(
          listener: (context, state) {
            if (state is ForgotPasswordConfirmExpiredOTP) {
              FlushbarHelper.createError(
                      message: LocaleKeys
                          .forgot_password_confirmation_form_expired_otp
                          .tr())
                  .show(context);
            }

            if (state is ForgotPasswordConfirmWrongOTP) {
              FlushbarHelper.createError(
                      message: LocaleKeys
                          .forgot_password_confirmation_form_wrong_otp
                          .tr())
                  .show(context);
            }

            if (state is ForgotPasswordConfirmSuccess) {
              FlushbarHelper.createSuccess(
                      message:
                          LocaleKeys.forgot_password_confirmation_success.tr())
                  .show(context)
                  .then((value) => context
                      .navigateTo(LoginRoute(username: widget.username)));
            }
          },
          builder: (context, state) {
            final isLoading = state is ForgotPasswordConfirmLoading;

            return Form(
              key: _formKey,
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                children: [
                  FilledTextField(
                    readOnly: true,
                    initialValue: widget.username,
                    suffixIcon: const Icon(Icons.person),
                    label: LocaleKeys.forgot_password_form_username_title.tr(),
                    hint: LocaleKeys.forgot_password_form_username_hint.tr(),
                  ),
                  const SizedBox(height: 20),
                  FilledTextField(
                    readOnly: isLoading,
                    initialValue: otp,
                    suffixIcon: const Icon(Icons.qr_code),
                    label: LocaleKeys.forgot_password_form_otp_title.tr(),
                    hint: LocaleKeys.forgot_password_form_otp_hint.tr(),
                    onSaved: (val) => otp = val,
                    validator: RequiredValidator(
                        errorText: LocaleKeys.login_form_required.tr()),
                  ),
                  const SizedBox(height: 20),
                  FilledPasswordTextField(
                    readOnly: isLoading,
                    label:
                        LocaleKeys.forgot_password_form_new_password_title.tr(),
                    hint:
                        LocaleKeys.forgot_password_form_new_password_hint.tr(),
                    onSaved: (val) => newPassword = val,
                    validator: RequiredValidator(
                        errorText: LocaleKeys.login_form_required.tr()),
                  ),
                  const SizedBox(height: 20),
                  FilledButton.large(
                      isLoading: isLoading,
                      buttonText: LocaleKeys.forgot_password_button_save.tr(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          forgotPasswordConfirmBloc.add(
                              ForgotPasswordConfirmStart(
                                  form: ForgotPasswordFormModel(
                                      newPassword: newPassword!,
                                      otp: otp!,
                                      username: widget.username!)));
                        }
                      }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
