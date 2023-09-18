// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';

class ProfilePagePublications extends StatelessWidget {
  const ProfilePagePublications({
    super.key,
    this.currentUser = false,
    this.blocked = false,
  });

  final bool currentUser;

  final bool blocked;

  Widget _buildEmptyPosts(BuildContext context) {
    if (currentUser) {
      return SizedBox(
        height: 210.h,
        child: Center(
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
              Text(L10n.of(context)!.addPublication, style: NTypography.golosRegular14),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: 300.h,
      child: Center(
        child: Text(
          L10n.of(context)!.noPublications,
          style: NTypography.golosRegular14.copyWith(color: NColors.graySecondaryText),
        ),
      ),
    );
  }

  Widget _buildBlockedUser(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: Center(
        child: Text(
          'Пользователь заблокирован',
          style: NTypography.golosRegular14.copyWith(color: NColors.graySecondaryText),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (blocked) {
      return _buildBlockedUser(context);
    }

    return _buildEmptyPosts(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: _buildContent(context),
    );
  }
}
