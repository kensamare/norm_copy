//Flutter imports
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:norm/presentation/pages/grade_person_page/widgets/grade_person_page_base_slider.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';

class GradePersonPageSlider extends StatelessWidget {
  const GradePersonPageSlider(
      {Key? key,
      required this.value,
      required this.onChanged,
      required this.negativeTitle,
      required this.positiveTitle})
      : super(key: key);

  final int value;
  final Function(int value) onChanged;

  final String positiveTitle;
  final String negativeTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              positiveTitle,
              style: NTypography.golosRegular14,
            ),
            Text(
              negativeTitle,
              style: NTypography.golosRegular14,
            ),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        SizedBox(
          height: 42.h,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        height: 4.h,
                        color: NColors.gray4,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: (343.w / 11) * (value < 5 ? 5 - value : 0),
                            color: NColors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 1.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        height: 4.h,
                        color: NColors.gray4,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: (343.w / 11) * (value > 5 ? value - 5 : 0),
                            color: NColors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GradePersonBaseSlider(
                value: value,
                onChange: onChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
