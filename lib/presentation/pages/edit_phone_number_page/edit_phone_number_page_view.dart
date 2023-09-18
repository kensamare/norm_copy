// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/edit_phone_number_page/states/edit_phone_number_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/app_bar/n_app_bar.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/pages/edit_phone_number_page/widgets/edit_phone_number_popup.dart';

class EditPhoneNumberPageView extends StatelessWidget {
  const EditPhoneNumberPageView({super.key});

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return NAppBar(
      title: L10n.of(context)!.phoneNumber,
    );
  }

  void openEditPhonePopup(BuildContext context) async {
    service<AppRouter>().showBottomSheet(
      context,
      EditPhoneNumberPopup(phone: context.read<EditPhoneNumberState>().user?.phone),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Observer(
      builder: (context) {
        final EditPhoneNumberState state = context.watch<EditPhoneNumberState>();

        bool hasPhone = state.user?.phone != null;

        return Column(
          children: [
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
              child: Text(
                hasPhone
                    ? 'Ваш профиль привязан к этому номеру. Эта информация не будет показываться в вашем общедоступном профиле'
                    : 'Привяжите номер телефона к профилю. Эта информация не будет показываться в вашем общедоступном профиле',
                style: NTypography.golosRegular16.copyWith(color: NColors.gray),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 24.h),
            if (!hasPhone) _buildAddPhoneButton(context) else _buildPhoneNumber(context),
          ],
        );
      },
    );
  }

  Widget _buildAddPhoneButton(BuildContext context) {
    return GestureDetector(
      onTap: () => openEditPhonePopup(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 48.r,
            width: 48.r,
            decoration: const BoxDecoration(color: NColors.gray2, shape: BoxShape.circle),
            child: Center(
              child: NIcon(NIcons.add, size: 20.r),
            ),
          ),
          SizedBox(height: 16.h),
          Text(L10n.of(context)!.add, style: NTypography.golosRegular14),
        ],
      ),
    );
  }

  Widget _buildEditPhoneButton(BuildContext context) {
    return GestureDetector(
      onTap: () => openEditPhonePopup(context),
      child: NIcon(NIcons.edit_2, color: NColors.gray),
    );
  }

  Widget _buildDeletePhoneButton(BuildContext context) {
    return GestureDetector(
      onTap: () => openEditPhonePopup(context),
      child: NIcon(NIcons.trash, color: NColors.gray),
    );
  }

  Widget _buildPhoneNumber(BuildContext context) {
    final EditPhoneNumberState state = context.watch<EditPhoneNumberState>();

    return PaddedContent(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${state.user?.phone}', style: NTypography.rfDewiBold20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildEditPhoneButton(context),
              SizedBox(width: 16.w),
              _buildDeletePhoneButton(context),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildContent(context),
    );
  }
}
