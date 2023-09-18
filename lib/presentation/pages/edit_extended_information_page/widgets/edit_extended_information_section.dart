// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';

class EditExtendedInformationSection extends StatelessWidget {
  const EditExtendedInformationSection({
    super.key,
    required this.title,
    required this.onTap,
  });

  /// Section title.
  final String title;

  /// On tap callback.
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        height: 56.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: NTypography.golosRegular16),
              NIcon(NIcons.arrow_right_2, color: NColors.graySecondaryText),
            ],
          ),
        ),
      ),
    );
  }
}
