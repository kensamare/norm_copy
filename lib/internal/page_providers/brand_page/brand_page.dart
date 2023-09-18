// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/annotations.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/interfaces/profile.dart';
import 'package:norm/internal/page_providers/brand_page/states/brand_state.dart';
import 'package:norm/presentation/pages/brand_page/brand_page_view.dart';

class BrandPage extends StatelessWidget {
  const BrandPage({
    super.key,
    @pathParam required this.id,
    this.fromProfile,
  });

  /// Brand ID.
  final int id;

  /// Parent profile route.
  final Profile? fromProfile;

  static const String routeName = '/brand';

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => BrandState(id: id)..initialize(),

      // Initialize instantly.
      lazy: false,
      child: BrandPageView(fromProfile: fromProfile),
    );
  }
}
