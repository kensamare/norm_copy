// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:norm/domain/models/interfaces/profile.dart';
import 'package:norm/presentation/pages/user_invitation_confirmation_page/user_invitation_confirmation_page_view.dart';

class UserInvitationConfirmationPage extends StatelessWidget {
  const UserInvitationConfirmationPage({
    Key? key,
    required this.invitedBy,
  }) : super(key: key);

  static const String routeName = '/invitation-confirmation-page';

  /// The user actual user has been invited by.
  final Profile invitedBy;

  @override
  Widget build(BuildContext context) {
    return UserInvitationConfirmationPageView(invitedBy: invitedBy);
  }
}
