// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/edit_specialities_page/states/edit_specialities_state.dart';
import 'package:norm/presentation/pages/edit_specialities_page/edit_specialities_page_view.dart';

class EditSpecialitiesPage extends StatelessWidget {
  const EditSpecialitiesPage({super.key});

  static const String routeName = '/edit-specialities-page';

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => EditSpecialitiesState(),
      child: const EditSpecialitiesPageView(),
    );
  }
}
