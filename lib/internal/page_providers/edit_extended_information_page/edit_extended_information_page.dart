// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/edit_extended_information_page/states/edit_extended_information_state.dart';

class EditExtendedInformationPage extends StatelessWidget implements AutoRouteWrapper {
  const EditExtendedInformationPage({super.key});

  static const String routeName = '/edit-extended-information-page';

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return Provider(
      create: (_) => EditExtendedInformationState(),
      child: this,
    );
  }
}
