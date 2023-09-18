// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/circle/circle.dart';
import 'package:norm/internal/page_providers/profile_circles_page/states/profile_circles_state.dart';
import 'package:norm/presentation/pages/profile_circles_users_page/profile_circles_invites_page_view.dart';
import 'package:norm/presentation/pages/profile_circles_users_page/profile_circles_users_page_view.dart';

class ProfileCirclesUsersPage extends StatefulWidget {
  const ProfileCirclesUsersPage({
    super.key,
    required this.circle,
  });

  static const String routeName = 'information';

  final Circle circle;

  @override
  State<ProfileCirclesUsersPage> createState() => _ProfileCirclesUsersPageState();
}

class _ProfileCirclesUsersPageState extends State<ProfileCirclesUsersPage> {
  @override
  void initState() {
    context.read<ProfileCirclesState>().setCircle(widget.circle);
    context.read<ProfileCirclesState>().initialize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.circle.id == Circle.INVITES_ID) {
      return const ProfileCirclesInvitesPageView();
    }

    return const ProfileCirclesUsersPageView();
  }
}
