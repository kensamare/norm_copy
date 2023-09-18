// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/phone_confirmation_state/phone_confirmation_state.dart';
import 'package:norm/presentation/global/error_message/error_message.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/pin_code_field/pin_code_field.dart';
import 'package:norm/presentation/global/registration_template_page/registration_template_page.dart';

class RegistrationPhoneCodeConfirmationPageView extends StatelessWidget {
  const RegistrationPhoneCodeConfirmationPageView({super.key});

  PhoneConfirmationState get state => service<PhoneConfirmationState>();
  AppRouter get router => service<AppRouter>();

  Future<void> _sendRequest() async {
    final bool result = await state.confirmPhone();

    if (result) {
      router.pop(true);
    }
  }

  Widget _buildSendButton(BuildContext context) {
    return Observer(
      builder: (context) => NButton(
        onPressed: _sendRequest,

        // Отправить.
        title: L10n.of(context)!.send,
        width: double.infinity,
        active: state.filledCode,
        isLoading: state.isLoading,
      ),
    );
  }

  Widget _buildPinCodeField(BuildContext context) {
    return PinCodeField(
      length: PhoneConfirmationState.INPUT_CODE_LENGTH,
      inputType: TextInputType.number,
      onChanged: state.setCode,
    );
  }

  Widget _buildContent(BuildContext context) {
    return PaddedContent(
      child: Column(
        children: [
          _buildPinCodeField(context),
          SizedBox(height: 40.h),
          _buildSendButton(context),
        ],
      ),
    );
  }

  Widget _buildErrors(BuildContext context) {
    return Observer(
      builder: (context) => ErrorMessage(
        message: errorMessagesLocalized(context, state.errors),
      ),
      warnWhenNoObservables: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationTemplatePage(
      // Введите код.
      header: L10n.of(context)!.enterCode,

      // Код отправлен на номер {number}.
      subtitle: L10n.of(context)!.codeIsSentToPhone(state.phone),

      content: _buildContent(context),

      errors: _buildErrors(context),
    );
  }
}
