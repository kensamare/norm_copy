// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';

// Project imports:
import 'package:norm/internal/page_providers/user_invitation_access_contacts_page/state/user_invitation_access_contacts_state.dart';
import 'package:norm/presentation/pages/user_invitation_access_contacts_page/user_invitation_access_contacts_page_view.dart';

class UserInvitationAccessContactsPage extends StatelessWidget {
  const UserInvitationAccessContactsPage({super.key});

  static const String routeName = '/user-invitation-access-contacts-page';

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => UserInvitationAccessContactsState(),
      child: const UserInvitationAccessContactsPageView(),
    );
  }
}
