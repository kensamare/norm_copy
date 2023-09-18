// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/interfaces/profile.dart';
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/reputation_dot/reputation_dot.dart';
import 'package:norm/presentation/global/user_avatar/user_avatar.dart';

class SpecialityWrapperLarge extends StatelessWidget {
  const SpecialityWrapperLarge({
    super.key,
    required this.speciality,
    this.icon,
    this.showIcon = true,
    this.profile,
  });

  final Speciality speciality;

  final NIcon? icon;

  /// Show suffic icon.
  final bool showIcon;

  /// Parent profile.
  final Profile? profile;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => service<AppRouter>().handleSpecialityRoute(speciality, profile),
      child: Ink(
        height: 48.h + 24.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
          child: Center(
            child: Row(
              children: [
                UserAvatar(
                  size: 48.r,
                  imageUrl: speciality.avatar250,
                  letter: speciality.title[0],
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            speciality.title,
                            style: NTypography.golosMedium14,
                          ),
                          SizedBox(width: 8.w),
                          Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: ReputationDot(
                              size: 10.r,
                              reputation: speciality.reputation,
                            ),
                          ),
                        ],
                      ),
                      if (speciality.description != null)
                        Text(
                          speciality.description!,
                          style: NTypography.golosRegular14.copyWith(color: NColors.gray),
                        ),
                    ],
                  ),
                ),
                if (showIcon) icon ?? NIcon(NIcons.arrow_right_2, color: NColors.gray),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
