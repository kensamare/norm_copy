// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/edit_contacts_page/states/edit_contacts_state.dart';
import 'package:norm/presentation/pages/edit_contacts_page/edit_contacts_page_view.dart';

class EditContactsPage extends StatelessWidget {
  const EditContactsPage({super.key});

  static const String routeName = '/edit-contacts-page';

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => EditContactsState(),
      child: const EditContactsPageView(),
    );
  }
}
