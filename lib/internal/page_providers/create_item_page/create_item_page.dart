// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/create_item_page/states/create_item_state.dart';
import 'package:norm/presentation/pages/create_item_page/create_item_page_view.dart';

class CreateItemPage extends StatelessWidget {
  const CreateItemPage({super.key});

  static const String routeName = '/create-item-page';

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CreateItemState(),
      child: const CreateItemPageView(),
    );
  }
}
