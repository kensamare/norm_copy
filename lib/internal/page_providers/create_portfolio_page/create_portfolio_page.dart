// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/create_portfolio_page/states/create_portfolio_state.dart';
import 'package:norm/presentation/pages/create_portfolio_page/create_portfolio_page_view.dart';

class CreatePortfolioPage extends StatelessWidget {
  const CreatePortfolioPage({super.key});

  static const String routeName = '/create-portfolio-page';

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CreatePortfolioState(),
      child: const CreatePortfolioPageView(),
    );
  }
}
