// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/career/career.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/user_avatar/user_avatar.dart';

class CareerWrapper extends StatelessWidget {
  const CareerWrapper({
    super.key,
    required this.career,
    this.onDelete,
    this.onEdit,
  });

  final Career career;

  /// On edit career callback.
  final Function()? onEdit;

  /// On delete career callback.
  final Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAvatar(imageUrl: career.brand?.avatar250, size: 48.r),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text('${career.brand?.title ?? career.customTitle}', style: NTypography.golosMedium16),
                    ),
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
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  career.position,
                  style: NTypography.golosMedium14.copyWith(color: NColors.gray),
                ),
                SizedBox(height: 4.h),
                Text(
                  career.description,
                  style: NTypography.golosMedium14.copyWith(color: NColors.gray),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
