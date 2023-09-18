// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

// Project imports:
import 'package:norm/domain/models/interfaces/profile.dart';
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/back_button/n_back_button.dart';
import 'package:norm/presentation/global/floating_options_button/floating_option.dart';
import 'package:norm/presentation/global/floating_options_button/floating_options_button.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/reputation_dot/reputation_dot.dart';
import 'package:norm/presentation/global/user_avatar/user_avatar.dart';

class SpecialityPageAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SpecialityPageAppBar({
    super.key,
    this.fromProfile,
    this.nickname = '',
    this.my = false,
  });

  /// Parent profile route.
  final Profile? fromProfile;

  /// Speciality nickname.
  final String nickname;

  /// My speciality or not.
  final bool my;

  @override
  State<SpecialityPageAppBar> createState() => _SpecialityPageAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SpecialityPageAppBarState extends State<SpecialityPageAppBar> {
  Widget _buildProfile(BuildContext context) {
    return Row(
      children: [
        UserAvatar(size: 24.r, imageUrl: widget.fromProfile!.avatar250),
        SizedBox(width: 8.w),
        Text('@${widget.fromProfile!.nickname}', style: NTypography.golosMedium12),
        SizedBox(width: 6.w),
        ReputationDot(
          size: 8.r,
          reputation: widget.fromProfile!.reputation,
        )
      ],
    );
  }

  Widget _buildMoreButton(BuildContext context) {
    if (widget.my) {
      return GestureDetector(
        onTap: () => Share.share(
          Speciality.shareLink(widget.nickname),
        ),
        child: NIcon(NIcons.share),
      );
    }

    return FloatingOptionsButton(
      options: [
        FloatingOption(
          icon: NIcons.share,
          title: 'Поделиться',
          onTap: () => Share.share(
            Speciality.shareLink(widget.nickname),
          ),
        ),
        if (!widget.my) ...[
          FloatingOption(
            icon: NIcons.complain,
            title: 'Пожаловаться на специальность',
            onTap: () => {},
            type: FloatingOptionType.alert,
          ),
        ],
      ],
      child: NIcon(NIcons.more),
    );
  }

  Widget _buildContent(BuildContext context) {
    return PaddedContent(
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const NBackButton(),
                    if (widget.fromProfile != null) ...[
                      SizedBox(width: 12.w),
                      _buildProfile(context),
                    ],
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: _buildMoreButton(context),
                ),
              ),
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
