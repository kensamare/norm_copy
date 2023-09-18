// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/hobby/hobby.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';

class HobbyWrapper extends StatelessWidget {
  const HobbyWrapper({
    super.key,
    required this.hobby,
    this.onEdit,
    this.onDelete,
  });

  final Hobby hobby;

  /// On edit hobby callback.
  final Function()? onEdit;

  /// On delete hobby callback.
  final Function()? onDelete;

  Widget _buildHobbyYears(BuildContext context) {
    return Text(
      '${hobby.years} лет',
      style: NTypography.golosRegular16.copyWith(color: NColors.gray),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  hobby.title,
                  style: NTypography.golosMedium16,
                  overflow: TextOverflow.ellipsis,
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
                _buildHobbyYears(context),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            hobby.level + (onEdit == null ? '' : ' • ${hobby.years} лет'),
            style: NTypography.golosMedium14.copyWith(color: NColors.gray),
          ),
          SizedBox(height: 4.h),
          Text(
            hobby.description,
            style: NTypography.golosMedium14.copyWith(color: NColors.gray),
          ),
        ],
      ),
    );
  }
}
