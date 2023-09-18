// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';

class NButton extends StatelessWidget {
  const NButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.icon,
    this.height,
    this.width,
    this.inverted = false,
    this.active = true,
    this.isLoading = false,
    this.style,
    this.colour,
  }) : super(key: key);

  /// On pressed callback.
  final Function() onPressed;

  /// Button label.
  final String title;

  /// Icon.
  final Widget? icon;

  /// Button custom height.
  final double? height;

  /// Button custom width.
  final double? width;

  /// Inverted button style or not. If inverted than background color will be light-gray and text is black.
  final bool inverted;

  /// Active button or not.
  final bool active;

  /// Whether to show loader instead of title or not.
  final bool isLoading;

  /// Text style.
  final TextStyle? style;

  /// Override button color.
  final Color? colour;

  /// Button background color.
  Color get color {
    if (colour != null) return colour!;

    if (!active || isLoading) {
      return NColors.gray;
    } else {
      return inverted ? NColors.gray2 : NColors.black;
    }
  }

  Color get textColor {
    if (!active || isLoading) {
      return NColors.graySecondaryText;
    } else {
      return inverted ? NColors.black : NColors.white;
    }
  }

  Widget _buildLoader(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(color: textColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: NColors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        onTap: (!active || isLoading) ? null : onPressed,
        child: Ink(
          height: height ?? 56.h,
          width: width ?? 200.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: color,
          ),
          child: isLoading
              ? _buildLoader(context)
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (icon != null) SizedBox(width: 24.r, child: icon),
                      Expanded(
                        child: Center(
                          child: Text(
                            title,
                            style: (style ?? NTypography.golosRegular16).copyWith(color: textColor, height: 1.0),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      if (icon != null) SizedBox(width: 24.r),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
