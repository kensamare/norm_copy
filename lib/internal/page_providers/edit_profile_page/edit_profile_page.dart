// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/edit_profile_page/states/edit_profile_state.dart';
import 'package:norm/presentation/pages/edit_profile_page/edit_profile_page_view.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  static const String routeName = '/edit-profile-page';

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => EditProfileState(),
      child: const EditProfilePageView(),
    );
  }
}
