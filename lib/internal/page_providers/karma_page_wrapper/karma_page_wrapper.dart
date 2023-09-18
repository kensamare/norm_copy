// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/karma_page_wrapper/states/karma_state.dart';

class KarmaPageWrapper extends StatelessWidget implements AutoRouteWrapper {
  const KarmaPageWrapper({super.key});

  static const String routeName = 'karma';

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return Provider(
      create: (_) => KarmaState(),
      child: this,
    );
  }
}
