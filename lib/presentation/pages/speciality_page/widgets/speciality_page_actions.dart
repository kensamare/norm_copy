// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/contact/contact.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/options_bottom_sheet/bottom_sheet_option.dart';
import 'package:norm/presentation/global/options_bottom_sheet/options_bottom_sheet.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';

class SpecialityPageActions extends StatelessWidget {
  const SpecialityPageActions({
    super.key,
    this.contacts = const [],
    this.onFollow,
    this.onUnfollow,
    this.my = false,
    this.blocked = false,
    this.followed = false,
    this.onEdit,
    this.onEditContacts,
  });

  final List<Contact> contacts;

  /// Current user speciality or not.
  final bool my;

  /// If this speciality is blocked or not.
  final bool blocked;

  /// If this speciality is followed or not.
  final bool followed;

  /// On follow speciality callback.
  final Function()? onFollow;

  /// On unfollow speciality callback.
  final Function()? onUnfollow;

  /// On tap edit brand button.
  final Function()? onEdit;

  /// On tap edit brand contacts button.
  final Function()? onEditContacts;

  AppRouter get router => service<AppRouter>();

  void _openMore(BuildContext context) => router.showBottomSheet(
        context,
        OptionsBottomSheet(
          options: [
            if (my) ...[
              BottomSheetOption(
                icon: NIcons.phone,
                title: 'Изменить контакты',
                onTap: () => onEditContacts?.call(),
              ),
              BottomSheetOption(
                icon: NIcons.user_square,
                title: 'Редактировать информацию',
                onTap: () => onEdit?.call(),
              ),
            ] else ...[
              BottomSheetOption(icon: NIcons.rating, title: 'Оценить бренд', onTap: () {}),
              if (followed)
                BottomSheetOption(
                  icon: NIcons.user_square,
                  title: 'Отписаться',
                  onTap: () => onUnfollow?.call(),
                )
              else
                BottomSheetOption(
                  icon: NIcons.phone,
                  title: 'Контакты',
                  onTap: () => router.openContactsPopup(context, contacts: contacts),
                ),
            ],
          ],
        ),
      );

  Widget _buildChangeButton(BuildContext context) {
    return NButton(
      width: (MediaQuery.of(context).size.width - 4 * NConstants.sidePadding.w - 24.r) / 2,
      height: 32.h,
      onPressed: () => onEdit?.call(),
      title: L10n.of(context)!.editProfile,
      style: NTypography.golosMedium14,
    );
  }

  Widget _buildFollowButton(BuildContext context) {
    return NButton(
      width: (MediaQuery.of(context).size.width - 4 * NConstants.sidePadding.w - 24.r) / 2,
      height: 32.h,
      onPressed: () => onFollow?.call(),
      title: 'Подписаться',
      style: NTypography.golosMedium14,
    );
  }

  Widget _buildReputationButton(BuildContext context) {
    return NButton(
      width: (MediaQuery.of(context).size.width - 4 * NConstants.sidePadding.w - 24.r) / 2,
      height: 32.h,
      onPressed: () {},
      title: L10n.of(context)!.reputation,
      style: NTypography.golosMedium14,
      inverted: true,
    );
  }

  Widget _buildContactButton(BuildContext context) {
    return NButton(
      width: (MediaQuery.of(context).size.width - 4 * NConstants.sidePadding.w - 24.r) / 2,
      height: 32.h,
      onPressed: () => router.openContactsPopup(context, contacts: contacts),
      title: 'Контакты',
      style: NTypography.golosMedium14,
    );
  }

  Widget _buildMoreButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _openMore(context),
      child: NIcon(NIcons.more_2),
    );
  }

  Widget _buildMySpecialityButton(BuildContext context) {
    return _buildChangeButton(context);
  }

  Widget _buildStrangeUserSpecialityButton(BuildContext context) {
    if (followed) {
      return _buildContactButton(context);
    }

    return _buildFollowButton(context);
  }

  Widget _buildContent(BuildContext context) {
    return PaddedContent(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (my) _buildMySpecialityButton(context) else _buildStrangeUserSpecialityButton(context),
          _buildReputationButton(context),
          _buildMoreButton(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildContent(context),
    );
  }
}
