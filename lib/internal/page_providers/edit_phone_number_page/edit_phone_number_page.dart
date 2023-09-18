// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/edit_phone_number_page/states/edit_phone_number_state.dart';
import 'package:norm/presentation/pages/edit_phone_number_page/edit_phone_number_page_view.dart';

class EditPhoneNumberPage extends StatelessWidget {
  const EditPhoneNumberPage({super.key});

  static const String routeName = '/edit-phone-number-page';

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => EditPhoneNumberState(),
      child: const EditPhoneNumberPageView(),
    );
  }
}
