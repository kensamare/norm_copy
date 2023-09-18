// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/education/education.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';

class EducationWrapper extends StatelessWidget {
  const EducationWrapper({
    super.key,
    required this.education,
    this.onEdit,
    this.onDelete,
  });

  final Education education;

  /// On edit education callback.
  final Function()? onEdit;

  /// On delete education callback.
  final Function()? onDelete;

  Widget _buildEducationEnd(BuildContext context) {
    return Text(
      '${education.year} г',
      style: NTypography.golosRegular16.copyWith(color: NColors.gray),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NIcon(NIcons.teacher, size: 48.r),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(education.title, style: NTypography.golosMedium16),
                SizedBox(height: 4.h),
                Text(
                  education.faculty + (onEdit == null ? '' : ' • ${education.year} г'),
                  style: NTypography.golosMedium14.copyWith(color: NColors.gray, height: 1.4),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          if (onEdit != null)
            Row(
              children: [
                if (onEdit != null)
                  GestureDetector(
                    onTap: onEdit,
                    child: NIcon(NIcons.edit_2, color: NColors.gray),
                  ),
                if (onDelete != null) ...[
                  SizedBox(width: 16.w),
                  GestureDetector(
                    onTap: onDelete,
                    child: NIcon(NIcons.trash, color: NColors.gray),
                  ),
                ],
              ],
            )
          else
            _buildEducationEnd(context),
        ],
      ),
    );
  }
}
