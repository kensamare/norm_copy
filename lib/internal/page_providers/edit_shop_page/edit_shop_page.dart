// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/brand/brand.dart';
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/internal/page_providers/edit_shop_page/states/edit_shop_state.dart';
import 'package:norm/presentation/pages/edit_shop_page/edit_shop_page_view.dart';

class EditShopPage extends StatelessWidget {
  const EditShopPage({
    super.key,
    this.speciality,
    this.brand,
  });

  static const String routeName = '/edit-shop-page';

  /// Initial speciality.
  final Speciality? speciality;

  /// Initial brand.
  final Brand? brand;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => EditShopState()..initialize(spec: speciality, brand: brand),

      /// Initialize instantly.
      lazy: false,
      child: const EditShopPageView(),
    );
  }
}
