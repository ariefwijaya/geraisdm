import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geraisdm/config/injectable/injectable_core.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/modules/profile/blocs/profile_password_bloc/profile_password_bloc.dart';
import 'package:geraisdm/modules/profile/models/profile_change_password_model.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/widgets/form_component.dart';

class ProfilePasswordScreen extends StatefulWidget {
  const ProfilePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ProfilePasswordScreen> createState() => _ProfilePasswordScreenState();
}

class _ProfilePasswordScreenState extends State<ProfilePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _oldPassword;
  String? _newPassword;
  late ProfilePasswordBloc profilePasswordBloc;

  @override
  void initState() {
    profilePasswordBloc = getIt.get<ProfilePasswordBloc>();
    super.initState();
  }

  @override
  void dispose() {
    profilePasswordBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => profilePasswordBloc,
      child: BlocConsumer<ProfilePasswordBloc, ProfilePasswordState>(
        bloc: profilePasswordBloc,
        listener: (context, state) {
          if (state is ProfilePasswordFailure) {
            FlushbarHelper.createError(
                    message: LocaleKeys.change_password_failure.tr())
                .show(context);
          }

          if (state is ProfilePasswordInvalid) {
            FlushbarHelper.createError(
                    message: LocaleKeys.change_password_invalid.tr())
                .show(context);
          }

          if (state is ProfilePasswordSuccess) {
            context.popRoute();
          }
        },
        builder: (context, state) {
          final isLoading = state is ProfilePasswordLoading;
          return Scaffold(
            appBar: AppBar(
              title: Text(LocaleKeys.profile_menu_change_password.tr()),
            ),
            body: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  FilledPasswordTextField(
                    label: LocaleKeys.change_password_old_title.tr(),
                    hint: LocaleKeys.change_password_old_hint.tr(),
                    validator: RequiredValidator(
                        errorText:
                            LocaleKeys.change_password_form_required.tr()),
                    onSaved: (val) => _oldPassword = val,
                  ),
                  const SizedBox(height: 16),
                  FilledPasswordTextField(
                    label: LocaleKeys.change_password_new_title.tr(),
                    hint: LocaleKeys.change_password_new_hint.tr(),
                    validator: RequiredValidator(
                        errorText:
                            LocaleKeys.change_password_form_required.tr()),
                    onSaved: (val) => _newPassword = val,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FilledButton.large(
                      buttonText: LocaleKeys.change_password_submit.tr(),
                      isLoading: isLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          profilePasswordBloc.add(ProfilePasswordChange(
                              form: ProfileChangePasswordModel(
                                  oldPassword: _oldPassword!,
                                  newPassword: _newPassword!)));
                        }
                      })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
