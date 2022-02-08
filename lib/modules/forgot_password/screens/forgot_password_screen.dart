import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/modules/forgot_password/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/form_component.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String? username;
  const ForgotPasswordScreen({Key? key, @queryParam this.username})
      : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? username;
  late ForgotPasswordBloc forgotPasswordBloc;

  @override
  void initState() {
    super.initState();
    forgotPasswordBloc = getIt.get<ForgotPasswordBloc>();
    username = widget.username;
  }

  @override
  void dispose() {
    forgotPasswordBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => forgotPasswordBloc,
      child: Scaffold(
        appBar: AppBar(
          leading: const RouteBackButton(),
          title: Text(LocaleKeys.forgot_password_title.tr()),
        ),
        body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordUserNotValid) {
              FlushbarHelper.createError(
                      message:
                          LocaleKeys.forgot_password_form_user_not_valid.tr())
                  .show(context);
            }

            if (state is ForgotPasswordFailure) {
              FlushbarHelper.createError(message: state.error.toString())
                  .show(context);
            }

            if (state is ForgotPasswordSuccess) {
              context.replaceRoute(ForgotPasswordConfirmRoute(
                  username: username,
                  expiry: state.data.expiry,
                  otpLength: state.data.otpLength));
            }
          },
          builder: (context, state) {
            final isLoading = state is ForgotPasswordLoading;
            return Form(
                key: _formKey,
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  children: [
                    FilledTextField(
                      readOnly: isLoading,
                      initialValue: username,
                      suffixIcon: const Icon(Icons.person),
                      label:
                          LocaleKeys.forgot_password_form_username_title.tr(),
                      hint: LocaleKeys.forgot_password_form_username_hint.tr(),
                      onSaved: (val) => username = val,
                      validator: RequiredValidator(
                          errorText: LocaleKeys.login_form_required.tr()),
                    ),
                    const SizedBox(height: 20),
                    FilledButton.large(
                        isLoading: isLoading,
                        buttonText: LocaleKeys.forgot_password_button_send.tr(),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            forgotPasswordBloc
                                .add(ForgotPasswordStart(username: username!));
                          }
                        }),
                  ],
                ));
          },
        ),
      ),
    );
  }
}
