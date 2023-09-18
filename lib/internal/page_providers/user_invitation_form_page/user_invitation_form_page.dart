// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:norm/presentation/pages/user_invitation_form_page/user_invitation_form_page_view.dart';

class UserInvitationFormPage extends StatelessWidget {
  const UserInvitationFormPage({Key? key}) : super(key: key);

  static const String routeName = 'form';

  @override
  Widget build(BuildContext context) {
    return const UserInvitationFormPageView();
  }
}
