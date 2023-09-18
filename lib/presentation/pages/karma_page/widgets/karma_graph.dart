// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';

class KarmaGraph extends StatelessWidget {
  const KarmaGraph({
    super.key,
    required this.title,
    this.min = 0,
    this.max = 10,
    this.value = 5,
  });

  final String title;

  final int min;
  final int max;

  final int value;

  Widget _buildGraph(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SvgPicture.asset('assets/karma/karma_graph.svg'),
        Transform.rotate(
          angle: -pi / 2 + pi * value / (max - min),
          child: Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: SvgPicture.asset('assets/karma/karma_arrow.svg'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Text(
            title,
            style: NTypography.golosRegular14.copyWith(color: NColors.gray),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          _buildGraph(context),
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  min.toString(),
                  style: NTypography.golosRegular14.copyWith(color: NColors.gray),
                ),
                Text(
                  value.toString(),
                  style: NTypography.golosRegular14,
                ),
                Text(
                  max.toString(),
                  style: NTypography.golosRegular14.copyWith(color: NColors.gray),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
