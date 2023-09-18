// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/country_code/country_code.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/country_codes_state/country_codes_state.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/phone_number_input/pick_country_popup.dart';

class PhoneNumberInput extends StatefulWidget {
  const PhoneNumberInput({
    super.key,
    required this.onChanged,
    this.onSubmitted,
    this.code,
  });

  /// User initial country code.
  final CountryCode? code;

  /// Callback when phone number or country code changes.
  final Function(CountryCode code, String number)? onChanged;

  /// Callback when user taps fast action on keyboard.
  final Function()? onSubmitted;

  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  final FocusNode _focusNode = FocusNode();

  /// App router.
  AppRouter get router => service<AppRouter>();

  /// Picked country code.
  CountryCode? code;

  /// Phone number.
  String phoneNumber = '';

  @override
  void initState() {
    final CountryCodesState countryCodesState = service<CountryCodesState>();

    // Country code. Random if not provided any by user.
    code = widget.code ?? countryCodesState.countryCodes[Random().nextInt(countryCodesState.countryCodes.length)];

    super.initState();
  }

  Future<void> _pickCountryCode() async {
    final CountryCode? _code = await router.showBottomSheet(
      context,
      PickCountryPopup(code: code!),
    );

    if (_code != null) setState(() => code = _code);
  }

  void _changePhoneNumber(String value) {
    phoneNumber = value;
    widget.onChanged?.call(code!, phoneNumber);
  }

  void _onSubmited(String _) {
    _focusNode.unfocus();
    widget.onSubmitted?.call();
  }

  Widget _buildPhoneInput(BuildContext context) {
    return Flexible(
      child: TextFormField(
        autofocus: true,
        focusNode: _focusNode,
        style: NTypography.golosRegular14.copyWith(height: 1.0),
        onChanged: _changePhoneNumber,
        onFieldSubmitted: _onSubmited,
        decoration: InputDecoration(
          hintStyle: NTypography.golosRegular14.copyWith(color: NColors.graySecondaryText, height: 1.0),
          hintText: L10n.of(context)!.phoneNumber,
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.send,
        // enabled: widget.editable,
      ),
    );
  }

  Widget _buildCountryCodePicker(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _pickCountryCode,
      child: Row(
        children: [
          NIcon(
            NIcons.flagPath(code!.id),
          ),
          SizedBox(width: 4.w),
          NIcon(NIcons.arrow_dropdown),
          SizedBox(width: 16.w),
          Text(
            code!.phoneCode,
            style: NTypography.golosRegular14.copyWith(height: 1.0),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return PaddedContent(
      child: Row(
        children: [
          _buildCountryCodePicker(context),
          SizedBox(width: 6.w),
          _buildPhoneInput(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 56.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: NColors.gray2,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: _buildContent(context),
      ),
    );
  }
}
