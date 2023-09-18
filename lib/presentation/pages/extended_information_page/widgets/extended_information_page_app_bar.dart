// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/interfaces/profile.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/back_button/n_back_button.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/reputation_dot/reputation_dot.dart';
import 'package:norm/presentation/global/user_avatar/user_avatar.dart';

class ExtendedInformationPageAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ExtendedInformationPageAppBar({
    super.key,
    required this.fromProfile,
  });

  /// Parent profile route.
  final Profile fromProfile;

  @override
  State<ExtendedInformationPageAppBar> createState() => _ExtendedInformationPageAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ExtendedInformationPageAppBarState extends State<ExtendedInformationPageAppBar> {
  Widget _buildProfile(BuildContext context) {
    return Row(
      children: [
        UserAvatar(size: 24.r, imageUrl: widget.fromProfile.avatar250),
        SizedBox(width: 8.w),
        Text('@${widget.fromProfile.nickname}', style: NTypography.golosMedium12),
        SizedBox(width: 6.w),
        ReputationDot(
          size: 8.r,
          reputation: widget.fromProfile.reputation,
        )
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return PaddedContent(
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Row(
            children: [
              const NBackButton(color: NColors.black),
              SizedBox(width: 12.w),
              _buildProfile(context),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      decoration: const BoxDecoration(color: NColors.white),
      child: _buildContent(context),
    );
  }
}
