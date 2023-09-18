// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/login_page/state/login_state.dart';
import 'package:norm/presentation/pages/login_page/login_page_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const String routeName = '/login-page';

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => LoginState(),
      child: const LoginPageView(),
    );
  }
}
