// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';

class NTextFieldDone extends StatelessWidget {
  const NTextFieldDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24.r,
      height: 24.r,
      child: const Icon(
        Icons.done_rounded,
        color: NColors.greenPrimary,
      ),
    );
  }
}
