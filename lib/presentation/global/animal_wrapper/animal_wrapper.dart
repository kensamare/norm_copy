// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/animal/animal.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';

class AnimalWrapper extends StatelessWidget {
  const AnimalWrapper({
    super.key,
    required this.animal,
    this.onEdit,
    this.onDelete,
  });

  final Animal animal;

  /// On edit animal callback.
  final Function()? onEdit;

  /// On delete animal callback.
  final Function()? onDelete;

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
                  animal.title,
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
                Text(
                  '${animal.age} лет',
                  style: NTypography.golosRegular16.copyWith(color: NColors.gray),
                ),
            ],
          ),
          if (animal.typeTitle != null) ...[
            // SizedBox(height: 2.h),
            Text(
              animal.typeTitle! + (onEdit == null ? '' : ' • ${animal.age} лет'),
              style: NTypography.golosMedium14.copyWith(color: NColors.gray),
            ),
          ],
          SizedBox(height: 4.h),
          Text(
            animal.description,
            style: NTypography.golosMedium14.copyWith(color: NColors.gray),
          ),
        ],
      ),
    );
  }
}
