// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';

class ProfilePageValues extends StatelessWidget {
  const ProfilePageValues({
    super.key,
    required this.onTapCirclesPage,
    this.followers = 0,
    this.invites = 0,
    this.contacts = 0,
    this.mutualContacts = 0,
    this.currentUser = false,
  });

  final Function() onTapCirclesPage;

  /// Followers count.
  final int followers;

  /// Invites count.
  final int invites;

  /// Contacts count.
  final int contacts;

  /// Mutual contacts count.
  final int mutualContacts;

  final bool currentUser;

  Widget _buildValue(BuildContext context, {required int value, required String title}) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value.toString(), style: NTypography.golosRegular16),
          Text(
            title,
            style: NTypography.golosRegular12.copyWith(color: NColors.gray),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTapCirclesPage,
      child: SizedBox(
        width: 50.w,
        child: Align(
          alignment: Alignment.centerRight,
          child: NIcon(
            NIcons.arrow_right_2,
            color: NColors.graySecondaryText,
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return PaddedContent(
      child: Row(
        children: [
          _buildValue(context, value: contacts, title: 'Контактов'),
          if (currentUser)
            _buildValue(context, value: invites, title: 'Инвайта')
          else
            _buildValue(context, value: mutualContacts, title: 'Общих друзей'),
          _buildValue(context, value: followers, title: 'Подписчиков'),
          _buildCircleButton(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72.h,
      child: Center(
        child: _buildContent(context),
      ),
    );
  }
}
