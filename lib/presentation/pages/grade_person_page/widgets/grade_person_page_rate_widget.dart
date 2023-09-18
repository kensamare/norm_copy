import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:norm/internal/utils/infrastructure.dart';

class GradePersonPageRateWidget extends StatelessWidget {
  const GradePersonPageRateWidget({Key? key, required this.onChanged, required this.rate}) : super(key: key);

  final Function(int value) onChanged;
  final int rate;

  List<Widget> _generateScale(BuildContext context) {
    List<Color> clrs = [
      NColors.reputationRed,
      NColors.reputationRed,
      NColors.reputationOrange,
      NColors.reputationOrange,
      NColors.reputationOrange,
      NColors.reputationYellow,
      NColors.reputationYellow,
      NColors.reputationYellow,
      NColors.reputationGreen,
      NColors.reputationGreen,
    ];

    List<Widget> scale = [];
    for (int i = 0; i < 10; i++) {
      scale.add(
        GestureDetector(
          onTap: () {
            onChanged(i);
          },
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Container(
              height: 24.w,
              width: 12.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.r)),
                color: rate >= i ? clrs[i] : NColors.gray2,
              ),
            ),
          ),
        ),
      );
    }
    return scale;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        double dx = details.localPosition.dx;
        if (dx > 190.w) {
          dx = 190.w;
        }
        if (dx < 0) {
          dx = 0;
        }
        onChanged(dx ~/ 19);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: _generateScale(context),
        ),
      ),
    );
  }
}
