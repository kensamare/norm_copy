// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';

class NHorizontalDivider extends StatelessWidget {
  const NHorizontalDivider({
    super.key,
    this.height = 8,
  });

  /// Divider height.
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      color: NColors.gray2,
    );
  }
}
