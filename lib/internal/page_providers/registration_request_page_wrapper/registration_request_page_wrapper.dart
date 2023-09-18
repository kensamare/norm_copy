// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/registration_request_page/state/registration_request_state.dart';

class RegistrationRequestPageWrapper extends StatelessWidget implements AutoRouteWrapper {
  const RegistrationRequestPageWrapper({super.key});

  static const String routeName = '/registration-request-page-wrapper';

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return Provider(
      create: (_) => RegistrationRequestState(),
      child: this,
    );
  }
}
