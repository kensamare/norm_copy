// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';

class NTextFieldLoader extends StatelessWidget {
  const NTextFieldLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24.r,
      height: 24.r,
      child: CircularProgressIndicator(
        color: NColors.greenPrimary,
        strokeWidth: 1.5.r,
      ),
    );
  }
}
