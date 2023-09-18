// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/language/language.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';

class LanguageWrapper extends StatelessWidget {
  const LanguageWrapper({
    super.key,
    required this.language,
    this.onEdit,
    this.onDelete,
  });

  final Language language;

  /// On edit language callback.
  final Function()? onEdit;

  /// On delete language callback.
  final Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28.w,
            height: 20.h,
            color: NColors.gray2,
          ),
          SizedBox(width: 26.w),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      language.title,
                      style: NTypography.golosMedium16.copyWith(height: 1.0),
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
                  languageLevel(context, language.level),
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
