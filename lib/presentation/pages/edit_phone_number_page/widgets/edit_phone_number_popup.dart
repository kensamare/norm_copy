// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/phone_confirmation_state/phone_confirmation_state.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/phone_number_input/phone_number_input.dart';
import 'package:norm/presentation/pages/edit_phone_number_page/widgets/confirm_phone_number_popup.dart';

class EditPhoneNumberPopup extends StatefulWidget {
  const EditPhoneNumberPopup({
    super.key,
    this.phone,
  });

  /// Current user phone number (when editing). Could be null.
  final String? phone;

  @override
  State<EditPhoneNumberPopup> createState() => _EditPhoneNumberPopupState();
}

class _EditPhoneNumberPopupState extends State<EditPhoneNumberPopup> {
  PhoneConfirmationState get state => service<PhoneConfirmationState>();

  Widget _buildTitle(BuildContext context) {
    return Text('Укажите телефон', style: NTypography.rfDewiSemibold32);
  }

  Widget _buildPhoneNumberField(BuildContext context) {
    return PhoneNumberInput(
      code: state.countryCode,
      onChanged: (code, number) => state.changePhoneNumber(code, number),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return NButton(
      width: double.infinity,
      onPressed: () async {
        final NavigatorState navigator = Navigator.of(context);
        final bool result = await state.requestPhoneConfirmation();

        if (result) {
          // ignore: use_build_context_synchronously
          final bool confirmationResult = await service<AppRouter>().showBottomSheet(
                context,
                const ConfirmPhoneNumberPopup(),
              ) ??
              false;

          if (confirmationResult) navigator.pop();
        }
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
            SizedBox(height: 108.h),
            _buildPhoneNumberField(context),
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
