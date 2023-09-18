// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/profile_circles_page/states/profile_circles_state.dart';

class ProfileCirclesPageWrapper extends StatelessWidget implements AutoRouteWrapper {
  const ProfileCirclesPageWrapper({
    super.key,
    @pathParam required this.userId,
    this.currentUser = false,
  });

  static const String routeName = '/profile-circles-page/:userId';

  /// ID of user.
  final int userId;

  /// Whether it is current user or not.
  final bool currentUser;

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return Provider(
      create: (_) => ProfileCirclesState(
        userId: userId,
        currentUser: currentUser,
      ),
      child: this,
    );
  }
}
