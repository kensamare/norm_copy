// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';

class NStatusSwitcher extends StatelessWidget {
  const NStatusSwitcher({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
  });

  /// Switcher title.
  final String title;

  /// On changed switcher function;
  final Function(bool) onChanged;

  /// Current switcher value.
  final bool value;

  Widget _buildCheckbox(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onChanged(!value),
      child: AnimatedCrossFade(
        firstChild: NIcon(NIcons.checkbox),
        secondChild: NIcon(NIcons.checkbox_on),
        crossFadeState: value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: NConstants.defaultAnimationDuration * 0.5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40.h,
      decoration: BoxDecoration(
        color: NColors.gray3,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: PaddedContent(
        child: Row(
          children: [
            _buildCheckbox(context),
            SizedBox(width: 8.w),
            Text(title, style: NTypography.golosRegular14),
          ],
        ),
      ),
    );
  }
}
