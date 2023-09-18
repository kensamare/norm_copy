// Flutter imports:
import 'package:flutter/material.dart';

class BrandPageFeed extends StatelessWidget {
  const BrandPageFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) => const SizedBox.shrink(),
      itemCount: 0,
    );
  }
}
