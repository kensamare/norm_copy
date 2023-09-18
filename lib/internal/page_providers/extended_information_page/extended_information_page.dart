// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/interfaces/profile.dart';
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/page_providers/extended_information_page/states/extended_information_state.dart';
import 'package:norm/presentation/pages/extended_information_page/extended_information_page_view.dart';

class ExtendedInformationPage extends StatelessWidget {
  const ExtendedInformationPage({
    super.key,
    required this.fromProfile,
  });

  static const String routeName = '/extended-information-page';

  ///
  final Profile fromProfile;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => ExtendedInformationState(user: fromProfile as User),
      child: ExtendedInformationPageView(fromProfile: fromProfile),
    );
  }
}
