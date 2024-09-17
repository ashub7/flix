import 'package:flix/core/di/injector.dart';
import 'package:flix/core/extension/build_context_ext.dart';
import 'package:flix/core/extension/text_style_extension.dart';
import 'package:flix/ui/config/app_router.dart';
import 'package:flix/ui/config/rout_names.dart';
import 'package:flix/ui/features/login/bloc/login_bloc.dart';
import 'package:flix/ui/widgets/form_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/progress_loader.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(context.loc.login),
            automaticallyImplyLeading: false,
          ),
          body: BlocListener<LoginBloc, LoginState>(
            bloc: BlocProvider.of<LoginBloc>(context),
            listener: (context, state) {
              if (state is LoginError) {
                context.showErrorSnackBar(state.errorType.errorString(context));
              } else if (state is LoginSuccess) {
                context.go(RoutesName.home.path);
              }
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        20.verticalSpaceFromWidth,
                        const FlutterLogo(
                          size: 70,
                        ),
                        50.verticalSpaceFromWidth,
                        _emailField(),
                        _emailError(),
                        16.verticalSpaceFromWidth,
                        _passwordField(),
                        6.verticalSpaceFromWidth,
                        Text(
                          context.loc.password_config,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.grey),
                        ),
                        22.verticalSpaceFromWidth,
                        _submitButton(context),
                        _registerOption(),
                      ],
                    ),
                  ),
                ),
                _loginProgressView(context)
              ],
            ),
          ),
        ));
  }

  _submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        BlocProvider.of<LoginBloc>(context).add(LoginSubmitEvent(
            email: _emailController.text, password: _passwordController.text));
      },
      child: Text(context.loc.login),
    );
  }

  Widget _loginProgressView(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<LoginBloc>(context),
        builder: (context, state) {
          return Visibility(
            visible: state is LoginLoading,
            child: const ProgressLoader(),
          );
        });
  }

  _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return FormTextField(
          widgetKey: const Key("login_email_field"),
          _emailController,
          hintText: context.loc.email,
          keyboardType: TextInputType.emailAddress,
          showErrorBorder: state is LoginError &&
              state.errorType == LoginValidationError.invalidEmail,
          errorText: state is LoginError &&
              state.errorType == LoginValidationError.invalidEmail
              ? state.errorType.errorString(context)
              : null,
        );
      },
    );
  }

  _emailError() {
    return BlocBuilder<LoginBloc, LoginState>(
      bloc: BlocProvider.of<LoginBloc>(context),
      builder: (context, state) {
        if(state is LoginError &&
            state.errorType == LoginValidationError.invalidEmail){
          return const Text("Invalid");
        }
        return const SizedBox.shrink();
      },
    );
  }

  _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return FormTextField(
          widgetKey: const Key("login_password_field"),
          _passwordController,
          isPassword: true,
          hintText: context.loc.password,
          keyboardType: TextInputType.visiblePassword,
            showErrorBorder: state is LoginError && state.errorType == LoginValidationError.invalidPassword,
            errorText: state is LoginError && state.errorType == LoginValidationError.invalidPassword
                ? state.errorType.errorString(context)
                : null
        );
      },
    );
  }

  _registerOption() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(text: context.loc.no_account, style: context.bodySmall),
              TextSpan(
                text: context.loc.sign_up_here,
                style: context.titleMedium?.copyWith(
                    decoration: TextDecoration.underline
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.push(RoutesName.registration.path);
                  },
              ),
            ],
          )),
    );
  }
}
