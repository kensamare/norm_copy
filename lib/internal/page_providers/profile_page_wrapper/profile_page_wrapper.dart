// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/profile_page/states/profile_state.dart';

class ProfilePageWrapper extends StatelessWidget implements AutoRouteWrapper {
  const ProfilePageWrapper({
    super.key,
    @pathParam required this.username,
  });

  /// User username.
  final String username;

  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return Provider(
      create: (_) => ProfileState(username: username)..initialize(),

      // Initialize instantly.
      lazy: false,
      child: this,
    );
  }
}
