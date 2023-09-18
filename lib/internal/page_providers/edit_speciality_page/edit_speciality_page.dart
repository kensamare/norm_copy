// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/internal/page_providers/edit_speciality_page/states/edit_speciality_state.dart';

class EditSpecialityPage extends StatelessWidget implements AutoRouteWrapper {
  const EditSpecialityPage({
    super.key,
    required this.speciality,
  });

  static const String routeName = '/edit-speciality-page';

  final Speciality speciality;

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return Provider(
      create: (_) => EditSpecialityState(speciality: speciality)..initialize(),
      child: this,
    );
  }
}
