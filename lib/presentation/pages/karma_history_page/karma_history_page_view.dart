// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:norm/presentation/global/app_bar/n_app_bar.dart';

class KarmaHistoryPageView extends StatelessWidget {
  const KarmaHistoryPageView({super.key});

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return NAppBar(
      title: 'История кармы',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
    );
  }
}
