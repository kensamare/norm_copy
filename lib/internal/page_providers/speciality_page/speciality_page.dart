// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/interfaces/profile.dart';
import 'package:norm/internal/page_providers/speciality_page/states/speciality_state.dart';
import 'package:norm/presentation/pages/speciality_page/speciality_page_view.dart';

class SpecialityPage extends StatelessWidget {
  const SpecialityPage({
    super.key,
    @pathParam required this.id,
    this.fromProfile,
  });

  static const String routeName = '/speciality-page';

  /// Speciality ID.
  final int id;

  /// Parent profile route.
  final Profile? fromProfile;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => SpecialityState(id: id)..initialize(),

      // Load instantly.
      lazy: false,
      child: SpecialityPageView(fromProfile: fromProfile),
    );
  }
}
