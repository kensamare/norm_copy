// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/create_profession_page/states/create_profession_state.dart';
import 'package:norm/presentation/pages/create_profession_page/create_profession_page_view.dart';

class CreateProfessionPage extends StatelessWidget {
  const CreateProfessionPage({super.key});

  static const String routeName = '/create-profession-page';

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CreateProfessionState(),
      child: const CreateProfessionPageView(),
    );
  }
}
