// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/edit_extended_information_page/states/edit_extended_information_state.dart';
import 'package:norm/presentation/pages/edit_extended_information_languages_page/edit_extended_information_languages_page_view.dart';

class EditExtendedInformationLanguagesPage extends StatefulWidget {
  const EditExtendedInformationLanguagesPage({super.key});

  static const String routeName = 'languages';

  @override
  State<EditExtendedInformationLanguagesPage> createState() => _EditExtendedInformationLanguagesPageState();
}

class _EditExtendedInformationLanguagesPageState extends State<EditExtendedInformationLanguagesPage> {
  @override
  void initState() {
    context.read<EditExtendedInformationState>().loadLanguages();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const EditExtendedInformationLanguagesPageView();
  }
}
