// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/create_brand_page/states/create_brand_state.dart';
import 'package:norm/presentation/pages/create_brand_page/create_brand_page_view.dart';

class CreateBrandPage extends StatelessWidget {
  const CreateBrandPage({super.key});

  static const String routeName = '/create-brand-page';

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CreateBrandState(),
      child: const CreateBrandPageView(),
    );
  }
}
