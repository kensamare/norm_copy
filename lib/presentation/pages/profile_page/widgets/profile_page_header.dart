// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/interfaces/profile.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/reputation_dot/reputation_dot.dart';
import 'package:norm/presentation/global/user_avatar/user_avatar.dart';

class ProfilePageHeader extends StatelessWidget {
  const ProfilePageHeader({
    super.key,
    this.parent,
    this.avatar,
    this.firstName,
    this.lastName,
    this.invitedBy,
    this.reputation = 1.5,
    this.match = 0,
    this.karmaLevel = 0,
    this.circle = 0,
    this.isCurrentUser = false,
  });

  /// Parent profile model.
  final Profile? parent;

  /// User avatar.
  final String? avatar;

  /// First name.
  final String? firstName;

  /// Last name.
  final String? lastName;

  /// Name of invitation initiator.
  final Profile? invitedBy;

  /// User reputation.
  final double reputation;

  /// How much do this users match.
  final int match;

  /// Level of karma.
  final int karmaLevel;

  final int circle;

  /// Whether this profile is of current user or not.
  final bool isCurrentUser;

  Widget _buildKarmaIndicator(BuildContext context) {
    return ReputationDot(
      size: 32.r,
      reputation: reputation,
      child: Center(
        child: Text(
          reputation.toStringAsFixed(1),
          style: NTypography.golosMedium14.copyWith(color: NColors.white, height: 1.0),
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        UserAvatar(
          size: 96.r,
          imageUrl: avatar,
        ),
        _buildKarmaIndicator(context),
      ],
    );
  }

  Widget _buildInvitedBy(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: L10n.of(context)!.invitedBy,
            style: NTypography.golosRegular14.copyWith(color: NColors.gray),
          ),
          TextSpan(
            text: '@${invitedBy?.nickname}',
            style: NTypography.golosRegular14.copyWith(color: NColors.bluePrimary),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Route to user or brand profile page.
                if (invitedBy != null) service<AppRouter>().handleRouteToProfile(invitedBy!, parent);
              },
          ),
        ],
      ),
    );
  }

  Widget _buildUserNameSurname(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            '$firstName $lastName',
            style: NTypography.golosMedium16,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildKarmaProgress(BuildContext context) {
    return Row(
      children: [
        NIcon(karmaLevel < 0 ? NIcons.karma_down : NIcons.karma_up),
        SizedBox(width: 2.w),
        Text(
          karmaLevel.toString(),
          style: NTypography.golosRegular14.copyWith(color: karmaLevel < 0 ? NColors.redPrimary : NColors.greenPrimary),
        ),
      ],
    );
  }

  Widget _buildSecondaryInformationCurrentUser(BuildContext context) {
    return Row(
      children: [
        Text(
          L10n.of(context)!.karma,
          style: NTypography.golosRegular14.copyWith(color: NColors.gray),
        ),
        SizedBox(width: 2.w),
        _buildKarmaProgress(context),
      ],
    );
  }

  Widget _buildSecondaryInformationStrangerUser(BuildContext context) {
    return Row(
      children: [
        // Text(
        //   '$match% похожи',
        //   style: NTypography.golosRegular14.copyWith(color: NColors.gray),
        // ),
        Text(
          '$circle круг',
          style: NTypography.golosRegular14.copyWith(color: NColors.gray),
        ),
        SizedBox(width: 6.w),
        _buildKarmaProgress(context),
      ],
    );
  }

  Widget _buildPrimaryInformation(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserNameSurname(context),
          SizedBox(height: 8.h),
          if (invitedBy != null) ...[
            _buildInvitedBy(context),
            SizedBox(height: 2.h),
          ],
          if (isCurrentUser)
            _buildSecondaryInformationCurrentUser(context)
          else
            _buildSecondaryInformationStrangerUser(context),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return PaddedContent(
      child: Column(
        children: [
          Row(
            children: [
              _buildAvatar(context),
              SizedBox(width: 16.w),
              _buildPrimaryInformation(context),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: _buildContent(context),
    );
  }
}
