// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';

class ConfirmActionPopup extends StatelessWidget {
  const ConfirmActionPopup({
    super.key,
    required this.title,
    this.confirmWidget,
    this.cancelWidget,
  });

  /// Action title.
  final String title;

  /// Confirm widget.
  final Widget? confirmWidget;

  /// Cancel widget.
  final Widget? cancelWidget;

  @override
  Widget build(BuildContext context) {
    return PaddedContent(
      child: Column(
        children: [
          Text(title, style: NTypography.rfDewiBold24, textAlign: TextAlign.center),
          SizedBox(height: 40.h),
          if (confirmWidget != null) ...[
            confirmWidget!,
            SizedBox(height: 16.h),
          ],
          if (cancelWidget != null) ...[
            cancelWidget!,
            SizedBox(height: 16.h),
          ],
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
