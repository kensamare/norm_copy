// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/edit_main_information_page/states/edit_main_information_state.dart';
import 'package:norm/presentation/pages/edit_main_information_page/edit_main_information_page_view.dart';

class EditMainInformationPage extends StatelessWidget {
  const EditMainInformationPage({super.key});

  static const String routeName = '/edit-main-information-page';

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => EditMainInformationState()..initialize(),
      child: const EditMainInformationPageView(),
    );
  }
}
