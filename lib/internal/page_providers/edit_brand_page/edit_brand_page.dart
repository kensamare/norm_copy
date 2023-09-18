// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/brand/brand.dart';
import 'package:norm/internal/page_providers/edit_brand_page/states/edit_brand_state.dart';

class EditBrandPage extends StatelessWidget implements AutoRouteWrapper {
  const EditBrandPage({
    super.key,
    required this.brand,
  });

  static const String routeName = '/edit-brand-page';

  final Brand brand;

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return Provider(
      create: (_) => EditBrandState(brand: brand)..initialize(),
      child: this,
    );
  }
}
