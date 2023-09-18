// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:norm/presentation/pages/feed_page/feed_page_view.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  static const String routeName = 'feed';

  @override
  Widget build(BuildContext context) {
    return const FeedPageView();
  }
}
