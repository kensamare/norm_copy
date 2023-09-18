// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/registration_invitation_code_page/state/registration_invitation_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/agree_with_terms/agree_with_terms.dart';
import 'package:norm/presentation/global/error_message/error_message.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/pin_code_field/pin_code_field.dart';
import 'package:norm/presentation/global/registration_template_page/registration_template_page.dart';

class RegistrationInvitationCodePageView extends StatelessWidget {
  const RegistrationInvitationCodePageView({
    Key? key,
    this.hasInvite = false,
  }) : super(key: key);

  /// If user pressed I have invite after his request confirmation.
  final bool hasInvite;

  AppRouter get router => service<AppRouter>();

  /// I dont have invitation code option.
  Widget _buildIDontHaveInvitation(BuildContext context) {
    return GestureDetector(
      onTap: () => router.goToRegistrationRequestPage(),
      behavior: HitTestBehavior.translucent,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            L10n.of(context)!.dontHaveInvite,
            style: NTypography.golosRegular14,
          ),
          SizedBox(width: 8.w),
          NIcon(NIcons.arrow_right, size: 16.r),
        ],
      ),
    );
  }

  /// Enter button.
  Widget _buildEnterButton(BuildContext context) {
    return Observer(
      builder: (context) => NButton(
        onPressed: () async {
          final RegistrationInvitationState state = context.read<RegistrationInvitationState>();
          final bool result = await state.requestSessionFromToken();

          if (result) {
            // ignore: use_build_context_synchronously
            FocusScope.of(context).unfocus();

            // If we received invitation initiator then we go to invitation confirmation page.
            if (state.invitedBy != null) {
              router.replaceWithInvitationConfirmationPage(invitedBy: state.invitedBy!);
            }
          }
        },

        // Войти.
        title: L10n.of(context)!.loginEnter,
        width: MediaQuery.of(context).size.width,
        active: context.watch<RegistrationInvitationState>().filledCode &&
            context.watch<RegistrationInvitationState>().agreedToTerms,
        isLoading: context.watch<RegistrationInvitationState>().isLoading,
      ),
    );
  }

  Widget _buildPinCodeField(BuildContext context) {
    return PinCodeField(
      length: AuthState.INPUT_CODE_LENGTH,
      inputType: TextInputType.text,
      onChanged: context.watch<RegistrationInvitationState>().setCode,
    );
  }

  Widget _buildForm(BuildContext context) {
    return PaddedContent(
      child: Column(
        children: [
          _buildPinCodeField(context),
          SizedBox(height: 20.h),
          AgreeWithTerms(
            onChanged: context.read<RegistrationInvitationState>().setAgreedToTerms,
          ),
          SizedBox(height: 40.h),
          _buildEnterButton(context),
        ],
      ),
    );
  }

  Widget _buildErrors(BuildContext context) {
    return Observer(
      builder: (context) => ErrorMessage(
        message: errorMessagesLocalized(context, context.watch<RegistrationInvitationState>().errors),
      ),
      warnWhenNoObservables: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationTemplatePage(
      // Введите инвайт-код.
      header: L10n.of(context)!.enterInvitationCode,

      customSubtitle: !hasInvite ? _buildIDontHaveInvitation(context) : null,
      content: _buildForm(context),

      errors: _buildErrors(context),
    );
  }
}
