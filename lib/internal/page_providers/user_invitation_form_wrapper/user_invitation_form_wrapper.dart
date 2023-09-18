// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/user_invitation_form_page/state/user_invitation_form_state.dart';

class UserInvitationFormPageWrapper extends StatelessWidget implements AutoRouteWrapper {
  const UserInvitationFormPageWrapper({super.key});

  static const String routeName = '/user-invitation-form-page';

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return Provider(
      create: (_) => UserInvitationFormState()..initialize(),
      child: this,
    );
  }
}
