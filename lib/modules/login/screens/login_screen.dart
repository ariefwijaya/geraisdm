import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../../config/routes/routes.gr.dart';
import '../../../config/injectable/injectable_core.dart';
import '../blocs/login_bloc/login_bloc.dart';
import '../blocs/login_config_bloc/login_config_bloc.dart';
import '../models/login_config_model.dart';
import '../../../widgets/button_component.dart';
import '../../../widgets/common_placeholder.dart';
import '../../../widgets/form_component.dart';
import '../../../widgets/general_component.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../constant/localizations.g.dart';
import 'package:auto_route/auto_route.dart';

class LoginScreen extends StatefulWidget {
  @queryParam
  final String? username;
  const LoginScreen({Key? key, this.username}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? username;
  String? password;

  late LoginConfigBloc loginConfigBloc;
  late LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    loginConfigBloc = getIt.get<LoginConfigBloc>()..add(LoginConfigFetch());
    loginBloc = getIt.get<LoginBloc>();
    username = widget.username;
  }

  @override
  void dispose() {
    loginConfigBloc.close();
    loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginConfigBloc>(create: (context) => loginConfigBloc),
        BlocProvider<LoginBloc>(create: (context) => loginBloc),
      ],
      child: BlocBuilder<LoginConfigBloc, LoginConfigState>(
        bloc: loginConfigBloc,
        builder: (context, state) {
          if (state is LoginConfigSuccess) {
            return _buildConfigSuccess(context, config: state.config);
          }

          if (state is LoginConfigFailure) {
            return _buildConfigFailure();
          }

          return _buildConfigLoading();
        },
      ),
    );
  }

  Widget _buildConfigSuccess(BuildContext context,
      {required LoginConfigModel config}) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: loginBloc,
        listener: (context, state) {
          if (state is LoginSuccess) {
            context.router.popUntilRoot();
            context.replaceRoute(const HomeLayoutRoute());
          }

          if (state is LoginWrongPassword) {
            FlushbarHelper.createError(
                    message: LocaleKeys.login_wrong_password.tr())
                .show(context);
          }

          if (state is LoginFailed) {
            FlushbarHelper.createError(message: LocaleKeys.login_failed.tr())
                .show(context);
          }

          if (state is LoginNotRegistered) {
            FlushbarHelper.createAction(
                message: LocaleKeys.login_user_notfound.tr(),
                button: NudeButton.small(
                    infiniteWidth: false,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    buttonText: LocaleKeys.login_user_notfound_signup.tr(),
                    onPressed: () {
                      context.router.replace(RegisterRouter(
                          children: [RegisterRoute(username: username)]));
                    })).show(context);
          }

          if (state is LoginDuplicatedRequest) {
            FlushbarHelper.createError(
                    message: LocaleKeys.login_error_duplicated_request.tr())
                .show(context);
          }
        },
        builder: (context, state) {
          final isLoading = state is LoginLoading;
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        LocaleKeys.login_title.tr(),
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    NudeButton.large(
                        infiniteWidth: false,
                        buttonText: LocaleKeys.login_signup.tr(),
                        onPressed: () {
                          context.router.replace(RegisterRouter(
                              children: [RegisterRoute(username: username)]));
                        })
                  ],
                ),
                const SizedBox(height: 15),
                ImagePlaceholder(
                  height: 200,
                  imageUrl: config.illustration,
                  imageFit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                FilledTextField(
                  readOnly: isLoading,
                  initialValue: username,
                  suffixIcon: const Icon(Icons.person),
                  label: LocaleKeys.login_username_title.tr(),
                  hint: LocaleKeys.login_username_hint.tr(),
                  onSaved: (val) => username = val,
                  validator: RequiredValidator(
                      errorText: LocaleKeys.login_form_required.tr()),
                ),
                const SizedBox(height: 15),
                FilledPasswordTextField(
                  readOnly: isLoading,
                  label: LocaleKeys.login_password_title.tr(),
                  hint: LocaleKeys.login_password_hint.tr(),
                  onSaved: (val) => password = val,
                  validator: RequiredValidator(
                      errorText: LocaleKeys.login_form_required.tr()),
                ),
                const SizedBox(height: 20),
                FilledButton.large(
                    isLoading: isLoading,
                    buttonText: LocaleKeys.login_button.tr(),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        loginBloc.add(LoginStart(
                            username: username!, password: password!));
                      }
                    }),
                const SizedBox(height: 5),
                NudeButton.small(
                    buttonText: LocaleKeys.login_forgot_password.tr(),
                    onPressed: () {
                      context
                          .pushRoute(ForgotPasswordRoute(username: username));
                    })
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildConfigLoading() {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        children: [
          Text(
            LocaleKeys.login_title.tr(),
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

  Widget _buildConfigFailure() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.login_title.tr(),
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: CommonPlaceholder.noIcon(
          title: LocaleKeys.login_config_failed_title.tr(),
          subtitle: LocaleKeys.login_config_failed_subtitle.tr(),
          action: FilledButton.large(
              buttonText: LocaleKeys.login_config_failed_retry.tr(),
              onPressed: () => loginConfigBloc.add(LoginConfigFetch()))),
    );
  }
}
