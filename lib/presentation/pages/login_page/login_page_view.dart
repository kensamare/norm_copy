// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/login_page/state/login_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/error_message/error_message.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/password_text_field/password_text_field.dart';
import 'package:norm/presentation/global/registration_template_page/registration_template_page.dart';

class LoginPageView extends StatelessWidget {
  const LoginPageView({Key? key}) : super(key: key);

  AppRouter get router => service<AppRouter>();

  Widget _buildEnterButton(BuildContext context) {
    return Observer(
      builder: (context) => NButton(
        onPressed: () async {
          final bool result = await context.read<LoginState>().signIn();

          if (result) {
            // Await for dispose.
            await Future.delayed(NConstants.defaultAnimationDuration * 0.2);

            // Route to main page.
            router.replaceWithMainPage();
          }
        },

        // Войти.
        title: L10n.of(context)!.loginEnter,
        width: double.infinity,
        active: context.watch<LoginState>().canGoForward,
        isLoading: context.watch<LoginState>().isLoading,
      ),
    );
  }

  Widget _buildLoginField(BuildContext context) {
    return NTextField(
      width: double.infinity,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      capitalization: TextCapitalization.none,
      autofocus: true,

      // Почта или логин.
      hintText: L10n.of(context)!.emailOrLogin,
      onChanged: context.watch<LoginState>().setLogin,
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return PasswordTextField(
      onChanged: context.read<LoginState>().setPassword,
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      children: [
        _buildLoginField(context),
        SizedBox(height: 20.h),
        _buildPasswordField(context),
        SizedBox(height: 32.h),
        _buildEnterButton(context),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return PaddedContent(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLoginForm(context),
          SizedBox(height: 54.h),
        ],
      ),
    );
  }

  Widget _buildErrors(BuildContext context) {
    return Observer(
      builder: (context) => ErrorMessage(
        message: errorMessagesLocalized(context, context.watch<LoginState>().errors),
      ),
      warnWhenNoObservables: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationTemplatePage(
      // Войти.
      header: L10n.of(context)!.loginEnter,

      content: _buildContent(context),
      errors: _buildErrors(context),
    );
  }
}
