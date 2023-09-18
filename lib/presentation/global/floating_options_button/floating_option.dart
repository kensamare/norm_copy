// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';

enum FloatingOptionType { normal, alert }

class FloatingOption extends StatelessWidget {
  const FloatingOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
    this.type = FloatingOptionType.normal,
  });

  final String icon;
  final String title;
  final Function() onTap;

  final Color? color;

  final FloatingOptionType type;

  Color get _color {
    if (color != null) return color!;

    if (type == FloatingOptionType.normal) {
      return NColors.black;
    } else if (type == FloatingOptionType.alert) {
      return NColors.redError;
    }

    return NColors.reputationYellow;
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 56.h,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NIcon(icon, size: 24.r, color: _color),
              SizedBox(width: 12.w),
              Text(
                title,
                style: NTypography.golosRegular16.copyWith(height: 1.0, color: _color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
