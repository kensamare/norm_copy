import 'package:flutter/material.dart';

import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/user_avatar/user_avatar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradeHeader extends StatefulWidget {
  GradeHeader(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.onChanged,
      required this.grade})
      : super(key: key);

  final String imageUrl;
  final String name;
  final Function(int value) onChanged;
  int grade;

  @override
  State<GradeHeader> createState() => _GradeHeaderState();
}

class _GradeHeaderState extends State<GradeHeader> {
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
            setState(() {
              widget.grade = i;
              widget.onChanged(i);
            });
          },
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Container(
              height: 24.w,
              width: 12.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.r)),
                color: widget.grade >= i ? clrs[i] : NColors.gray2,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              height: 32.h,
            ),
            UserAvatar(imageUrl: widget.imageUrl, size: 64.r),
            Text(widget.name, style: NTypography.rfDewiBold20),
            GestureDetector(
              onHorizontalDragUpdate: (details) {
                double dx = details.localPosition.dx;
                if (dx > 190.w) {
                  dx = 190.w;
                }
                if (dx < 0) {
                  dx = 0;
                }
                setState(() {
                  widget.grade = (dx ~/ 19);
                  widget.onChanged(dx ~/ 19);
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Row(
                  children: _generateScale(context),
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            )
          ],
        ),
      ],
    );
  }
}
