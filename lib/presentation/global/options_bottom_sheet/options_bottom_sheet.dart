// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/options_bottom_sheet/bottom_sheet_option.dart';

class OptionsBottomSheet extends StatelessWidget {
  const OptionsBottomSheet({
    super.key,
    this.options = const [],
  });

  final List<BottomSheetOption> options;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.separated(
        padding: EdgeInsets.only(bottom: 12.h),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final BottomSheetOption option = options.elementAt(index);

          return InkWell(
            onTap: () {
              Navigator.of(context).pop();
              option.onTap();
            },
            child: option,
          );
        },
        itemCount: options.length,
        separatorBuilder: (_, __) => Container(height: 1.h, color: NColors.gray2),
      ),
    );
  }
}
