// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';

class NBackButton extends StatelessWidget {
  const NBackButton({
    Key? key,
    this.color,
    this.value,
  }) : super(key: key);

  /// Back button color.
  final Color? color;

  /// Value to return when pop.
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AutoRouter.of(context).pop(value),
      behavior: HitTestBehavior.translucent,
      child: NIcon(
        NIcons.arrow_left,
        size: 24.r,
        color: color ?? NColors.black,
      ),
    );
  }
}
