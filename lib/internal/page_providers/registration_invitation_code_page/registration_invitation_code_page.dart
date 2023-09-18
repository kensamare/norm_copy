// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/registration_invitation_code_page/state/registration_invitation_state.dart';
import 'package:norm/presentation/pages/registration_invitation_code_page/registration_invitation_code_page_view.dart';

class RegistrationInvitationCodePage extends StatelessWidget {
  const RegistrationInvitationCodePage({
    Key? key,
    this.hasInvite = false,
  }) : super(key: key);

  static const String routeName = '/registration-invitation-code-page';

  final bool hasInvite;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => RegistrationInvitationState(),
      child: RegistrationInvitationCodePageView(hasInvite: hasInvite),
    );
  }
}
