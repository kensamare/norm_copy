// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NIcon extends StatelessWidget {
  const NIcon(
    this.icon, {
    Key? key,
    this.color,
    this.size,
  }) : super(key: key);

  final String icon;

  /// Icon size.
  final double? size;

  /// Color of icon.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      height: size ?? 24.r,
      width: size ?? 24.r,
      color: color,
    );
  }
}
