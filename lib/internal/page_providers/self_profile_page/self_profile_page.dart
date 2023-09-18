// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/page_providers/profile_page/states/profile_state.dart';

class SelfProfilePage extends StatelessWidget implements AutoRouteWrapper {
  const SelfProfilePage({super.key});

  static const String routeName = 'self-profile-page';

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return Provider(
      create: (_) => ProfileState(username: User.CURRENT_USER_NAME)..initialize(),

      // Initialize instantly.
      lazy: false,
      child: this,
    );
  }
}
