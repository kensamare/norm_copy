// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/user_invitation_form_page/state/user_invitation_form_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';
import 'package:norm/presentation/global/error_message/error_message.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field_done.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field_loader.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/password_text_field/password_text_field.dart';
import 'package:norm/presentation/global/registration_template_page/registration_template_page.dart';

class UserInvitationRegistrationPageView extends StatefulWidget {
  const UserInvitationRegistrationPageView({super.key});

  @override
  State<UserInvitationRegistrationPageView> createState() => _UserInvitationRegistrationPageViewState();
}

class _UserInvitationRegistrationPageViewState extends State<UserInvitationRegistrationPageView> {
  late TextEditingController _emailController;
  late TextEditingController _loginController;

  AppRouter get router => service<AppRouter>();
  AuthState get authState => service<AuthState>();

  @override
  void initState() {
    final UserInvitationFormState state = context.read<UserInvitationFormState>();

    _emailController = TextEditingController(text: state.email);
    _loginController = TextEditingController(text: state.username);

    super.initState();
  }

  Widget _buildSignUpButton(BuildContext context) {
    return Observer(
      builder: (context) {
        final UserInvitationFormState state = context.watch<UserInvitationFormState>();

        return NButton(
          onPressed: () async {
            final bool result = await state.updateRegistrationData();

            if (result) router.replaceWithConnectTelegramAndPhonePage(tgCode: state.tgCode);
          },

          // Зарегистрироваться.
          title: L10n.of(context)!.signUp,
          width: double.infinity,
          active: state.canGoForwardSecond,
        );
      },
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return Observer(
      builder: (context) {
        final UserInvitationFormState state = context.watch<UserInvitationFormState>();

        final bool? successful = state.isEmailAvailable == null
            ? null
            : state.isEmailAvailable! && (!state.email.isBlank) && state.emailErrors.isEmpty;

        return NTextField(
          initialValue: state.email,
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: state.setEmail,
          onSubmitted: (_) => state.getEmailAvailability(),
          width: double.infinity,
          hintText: L10n.of(context)!.email,
          capitalization: TextCapitalization.none,
          autofocus: true,
          successful: successful,
          error: state.emailErrors.isNotEmpty,
          errorText: errorMessagesLocalized(context, state.emailErrors),
          suffix: state.isLoadingEmailAvailability
              ? const NTextFieldLoader()
              : ((successful ?? false) ? const NTextFieldDone() : const SizedBox.shrink()),
        );
      },
    );
  }

  Widget _buildLoginField(BuildContext context) {
    return Observer(
      builder: (context) {
        final UserInvitationFormState state = context.watch<UserInvitationFormState>();

        final bool? successful = state.isNicknameAvailable == null
            ? null
            : state.isNicknameAvailable! && (state.username.isNotEmpty) && state.nicknameErrors.isEmpty;

        return NTextField(
          initialValue: state.username,
          controller: _loginController,
          onChanged: state.setUsername,
          textInputAction: TextInputAction.next,
          capitalization: TextCapitalization.none,
          width: double.infinity,
          hintText: L10n.of(context)!.username,
          successful: successful,
          error: state.nicknameErrors.isNotEmpty,
          errorText: errorMessagesLocalized(context, state.nicknameErrors),
          suffix: state.isLoadingNicknameAvailability
              ? const NTextFieldLoader()
              : ((successful ?? false) ? const NTextFieldDone() : const SizedBox.shrink()),
        );
      },
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    final UserInvitationFormState state = context.read<UserInvitationFormState>();

    return PasswordTextField(
      onChanged: state.setPassword,
    );
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      children: [
        _buildEmailField(context),
        SizedBox(height: 20.h),
        _buildLoginField(context),
        SizedBox(height: 20.h),
        _buildPasswordField(context),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return PaddedContent(
      child: Column(
        children: [
          _buildForm(context),
          SizedBox(height: 44.h),
          _buildSignUpButton(context),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildErrors(BuildContext context) {
    return Observer(
      builder: (context) {
        final UserInvitationFormState state = context.watch<UserInvitationFormState>();

        return ErrorMessage(
          message: errorMessagesLocalized(context, state.errors),
        );
      },
      warnWhenNoObservables: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationTemplatePage(
      // Регистрация.
      header: L10n.of(context)!.registration,

      content: _buildContent(context),
      errors: _buildErrors(context),
    );
  }
}
