// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/brand/brand.dart';
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/internal/page_providers/edit_portfolio_page/states/edit_portfolio_state.dart';
import 'package:norm/presentation/pages/edit_portfolio_page/edit_portfolio_page_view.dart';

class EditPortfolioPage extends StatelessWidget {
  const EditPortfolioPage({
    super.key,
    this.speciality,
    this.brand,
  });

  static const String routeName = '/edit-portfolio-page';

  /// Initial speciality.
  final Speciality? speciality;

  /// Initial brand.
  final Brand? brand;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => EditPortfolioState()..initialize(spec: speciality, brand: brand),

      /// Initialize instantly.
      lazy: false,
      child: const EditPortfolioPageView(),
    );
  }
}
