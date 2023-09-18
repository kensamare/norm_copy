// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';

class EditProfileSection extends StatelessWidget {
  const EditProfileSection({
    super.key,
    required this.title,
    this.onTap,
    this.child,
  });

  final Function()? onTap;

  /// Section title.
  final String title;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: NConstants.sidePadding.w, right: NConstants.sidePadding.w, top: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: NTypography.golosMedium16,
                  ),
                  NIcon(NIcons.arrow_right_2, size: 18.r, color: NColors.graySecondaryText),
                ],
              ),
            ),
            if (child == null) SizedBox(height: 16.h),
            if (child != null)
              Padding(
                padding: EdgeInsets.only(bottom: NConstants.sidePadding.w, top: 8.h),
                child: child!,
              ),
          ],
        ),
      ),
    );
  }
}
