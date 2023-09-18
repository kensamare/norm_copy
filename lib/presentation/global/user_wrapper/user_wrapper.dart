// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/reputation_dot/reputation_dot.dart';
import 'package:norm/presentation/global/user_avatar/user_avatar.dart';

class UserWrapper extends StatelessWidget {
  const UserWrapper({
    super.key,
    required this.user,
  });

  final User user;

  Widget _buildUserName(BuildContext context) {
    return Row(
      children: [
        Text(
          '${user.firstName} ${user.lastName}',
          style: NTypography.golosMedium14,
        ),
      ],
    );
  }

  Widget _buildProfession(BuildContext context) {
    return Text(
      '${user.circle} круг',
      style: NTypography.golosRegular12.copyWith(color: NColors.gray, height: 1.0),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        UserAvatar(
          imageUrl: user.avatar250,
          size: 64.r,
        ),
        ReputationDot(
          size: 28.r,
          reputation: user.reputation,
          child: Center(
            child: Text(
              user.reputation.toStringAsFixed(1),
              style: NTypography.golosMedium14.copyWith(fontSize: 13.w, color: NColors.white, height: 1.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInvitedBy(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: L10n.of(context)!.invitedBy,
            style: NTypography.golosRegular12.copyWith(color: NColors.gray),
          ),
          TextSpan(
            text: '@${user.invitedBy?.nickname}',
            style: NTypography.golosRegular12.copyWith(color: NColors.bluePrimary),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Route to user or brand profile page.
                if (user.invitedBy != null) service<AppRouter>().handleRouteToProfile(user.invitedBy!);
              },
          ),
        ],
      ),
    );
  }

  Widget _buildInformation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildUserName(context),
        SizedBox(height: 4.h),
        _buildProfession(context),
        SizedBox(height: 6.h),
        _buildInvitedBy(context),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: NConstants.sidePadding.w),
      child: Row(
        children: [
          _buildAvatar(context),
          SizedBox(width: 16.w),
          _buildInformation(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => service<AppRouter>().goToProfilePage(user.nickname),
      child: Ink(
        child: _buildContent(context),
      ),
    );
  }
}
