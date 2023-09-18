// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TwoItemsSquareGrid extends StatelessWidget {
  const TwoItemsSquareGrid({
    super.key,
    required this.itemBuilder,
    this.itemCount = 0,
  });

  final Widget Function(BuildContext, int) itemBuilder;

  /// Number of items.
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2.r,
        crossAxisSpacing: 2.r,
        mainAxisExtent: MediaQuery.of(context).size.width / 2,
        childAspectRatio: 1,
      ),
      itemBuilder: itemBuilder,
      itemCount: itemCount,
    );
  }
}
