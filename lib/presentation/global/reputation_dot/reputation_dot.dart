// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/utils/infrastructure.dart';

class ReputationDot extends StatelessWidget {
  const ReputationDot({
    super.key,
    this.reputation = 0,
    this.size,
    this.child,
  });

  static const double defaultSize = 10;

  /// Reputation value.
  final double reputation;

  /// Size of dot.
  final double? size;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? defaultSize.r,
      width: size ?? defaultSize.r,
      decoration: BoxDecoration(
        color: NColors.colorOfReputation[User.reputationFromValue(reputation)],
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}
