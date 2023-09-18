// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/contact/contact.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/options_bottom_sheet/bottom_sheet_option.dart';
import 'package:norm/presentation/global/options_bottom_sheet/options_bottom_sheet.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';

class ProfilePageActions extends StatelessWidget {
  const ProfilePageActions({
    super.key,
    this.contacts = const [],
    this.onFollow,
    this.onUnfollow,
    this.onUnblock,
    this.goToGradePerson,
    this.userRates = false,
    this.currentUser = false,
    this.blocked = false,
    this.followed = false,
  });

  /// List of user contacts.
  final List<Contact> contacts;

  /// User model to do some actions with this
  final Function()? goToGradePerson;

  /// Current user, rated the selected user.
  final bool userRates;

  /// Current user actions or not.
  final bool currentUser;

  /// If this user is blocked or not.
  final bool blocked;

  /// If this user is followed or not.
  final bool followed;

  /// On follow user callback.
  final Function()? onFollow;

  /// On follow user callback.
  final Function()? onUnfollow;

  /// On block user callback.
  final Function()? onUnblock;

  AppRouter get router => service<AppRouter>();

  void _openMore(BuildContext context) => router.showBottomSheet(
        context,
        OptionsBottomSheet(
          options: [
            if (currentUser) ...[
              BottomSheetOption(
                icon: NIcons.phone,
                title: 'Изменить контакты',
                onTap: () => router.goToEditContactsPage(),
              ),
              BottomSheetOption(
                icon: NIcons.user_square,
                title: 'Редактировать информацию о себе',
                onTap: () => router.goToEditMainInformationPage(),
              ),
            ] else ...[
              BottomSheetOption(
                icon: NIcons.rating,
                title: userRates ? 'Пользователь уже оценен' : 'Оценить пользователя',
                onTap: () => userRates ? null : goToGradePerson?.call(),
              ),
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
      onPressed: () => service<AppRouter>().goToEditProfilePage(),
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

  Widget _buildCurrentUserButton(BuildContext context) {
    return _buildChangeButton(context);
  }

  Widget _buildStrangeUserButton(BuildContext context) {
    if (followed) {
      return _buildContactButton(context);
    }

    return _buildFollowButton(context);
  }

  Widget _buildUnblockButton(BuildContext context) {
    return NButton(
      height: 32.h,
      width: double.infinity,
      onPressed: () => onUnblock?.call(),
      title: 'Разблокировать',
      style: NTypography.golosMedium14,
    );
  }

  Widget _buildContent(BuildContext context) {
    return PaddedContent(
      child: blocked
          ? _buildUnblockButton(context)
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentUser) _buildCurrentUserButton(context) else _buildStrangeUserButton(context),
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
