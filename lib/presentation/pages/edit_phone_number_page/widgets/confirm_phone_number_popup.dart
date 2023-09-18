// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/phone_confirmation_state/phone_confirmation_state.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/back_button/n_back_button.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/pin_code_field/pin_code_field.dart';

class ConfirmPhoneNumberPopup extends StatelessWidget {
  const ConfirmPhoneNumberPopup({super.key});

  PhoneConfirmationState get state => service<PhoneConfirmationState>();

  Widget _buildTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const NBackButton(),
        Text('Введите код', style: NTypography.rfDewiSemibold32),
        SizedBox(width: 24.r),
      ],
    );
  }

  Widget _buildPinField(BuildContext context) {
    return PinCodeField(onChanged: state.setCode);
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      'Код отправлен на номер\n${state.phone}',
      style: NTypography.golosRegular16.copyWith(color: NColors.graySecondaryText),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return NButton(
      width: double.infinity,
      onPressed: () async {
        final NavigatorState navigator = Navigator.of(context);
        final bool result = await state.confirmPhone();

        if (result) navigator.pop(true);
      },
      title: 'Отправить',
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardSizeProvider(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTitle(context),
            SizedBox(height: 20.h),
            _buildSubtitle(context),
            SizedBox(height: 40.h),
            _buildPinField(context),
            SizedBox(height: 40.h),
            _buildSaveButton(context),
            Consumer<ScreenHeight>(
              builder: (context, value, _) => SizedBox(height: value.isOpen ? (value.keyboardHeight + 24.h) : 40.h),
            ),
          ],
        ),
      ),
    );
  }
}
