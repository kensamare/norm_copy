// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/internal/utils/infrastructure.dart';

class SpecialityWrapper extends StatelessWidget {
  const SpecialityWrapper({
    super.key,
    required this.speciality,
    this.onTap,
    this.isChosen = false,
  });

  /// On tap speciality callback.
  final Function()? onTap;

  final Speciality speciality;

  /// If speciality is chosen or not.
  final bool isChosen;

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 24.w,
            child: SvgPicture.network(speciality.icon),
          ),
          SizedBox(width: 8.w),
          Text(
            speciality.title,
            style: NTypography.golosRegular14
                .copyWith(color: isChosen ? NColors.black : NColors.graySecondaryText, height: 1.0),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      borderRadius: BorderRadius.circular(48.r),
      child: AnimatedContainer(
        duration: NConstants.defaultAnimationDuration,
        height: 48.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48.r),
          color: isChosen ? NColors.white : NColors.gray2,
        ),
        child: _buildContent(context),
      ),
    );
  }
}
