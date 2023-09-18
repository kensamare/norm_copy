import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:norm/internal/utils/infrastructure.dart';

class GradePersonBaseSlider extends StatelessWidget {
  GradePersonBaseSlider({Key? key, required this.value, required this.onChange}) : super(key: key);

  final Function(int value) onChange;

  final int value;

  final double stepInPixels = 343.w / 11;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: value * (stepInPixels - 0.7.w),
      child: GestureDetector(
        onPanUpdate: (details) {
          if (details.globalPosition.dx < stepInPixels) {
            onChange(0);
          } else if (details.globalPosition.dx >= 10 * stepInPixels) {
            onChange(10);
          } else if (details.globalPosition.dx <= (value - 1) * stepInPixels) {
            onChange(value - 1);
          } else if (details.globalPosition.dx >= (value + 1) * stepInPixels) {
            onChange(value + 1);
          }
        },
        child: Container(
          height: 40.r,
          width: 40.r,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: NColors.gray3, width: 1.r),
              boxShadow: [BoxShadow(offset: Offset(0, 1.h), blurRadius: 2.r, color: Colors.black.withOpacity(0.1))]),
          child: Center(
            child: Container(
              height: 8.r,
              width: 8.r,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
