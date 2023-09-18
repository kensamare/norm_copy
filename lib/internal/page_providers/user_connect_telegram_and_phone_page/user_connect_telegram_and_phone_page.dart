// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/user_connect_telegram_and_phone_page/state/connect_telegram_and_phone_state.dart';
import 'package:norm/presentation/pages/user_connect_telegram_and_phone_page/user_connect_telegram_and_phone_page_view.dart';

class UserConnectTelegramAndPhonePage extends StatelessWidget {
  const UserConnectTelegramAndPhonePage({
    super.key,
    this.invitation = false,
  });

  static const String routeName = '/user-connect-telegram-and-phone-page';

  /// Went after invitation or request. If after request, then skip routes to request confirmation page.
  final bool invitation;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => ConnectTelegramAndPhoneState()..initialize(),
      child: UserConnectTelegramAndPhonePageView(invitation: invitation),
    );
  }
}
