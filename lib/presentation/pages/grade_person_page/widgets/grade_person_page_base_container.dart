//Flutter imports
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

//Project imports:
import 'package:norm/internal/utils/infrastructure.dart';

class GradePersonPageBaseContainer extends StatelessWidget {
  const GradePersonPageBaseContainer({Key? key, required this.title, required this.child, this.description})
      : super(key: key);

  final String title;
  final String? description;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: NTypography.rfDewiBold20,
          ),
          SizedBox(
            height: 16.h,
          ),
          if (description != null) ...[
            Text(
              description!,
              style: NTypography.golosRegular16.copyWith(color: NColors.gray),
            ),
            SizedBox(
              height: 16.h,
            ),
          ],
          child,
        ],
      ),
    );
  }
}
