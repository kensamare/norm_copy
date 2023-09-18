// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/user_invitation_access_contacts_page/state/user_invitation_access_contacts_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/registration_template_page/registration_template_page.dart';

class UserInvitationAccessContactsPageView extends StatelessWidget {
  const UserInvitationAccessContactsPageView({super.key});

  AppRouter get router => service<AppRouter>();

  void _replaceWithMainPage() async {
    // Replace route with main page.
    router.replaceWithMainPage(profile: true);
  }

  Widget _buildTurnOnButton(BuildContext context) {
    return Observer(
      builder: (context) => NButton(
        onPressed: () async {
          final result = await context.read<UserInvitationAccessContactsState>().provideContacts();

          if (result) {
            _replaceWithMainPage();
          }
        },

        // Далее.
        title: L10n.of(context)!.yesTurnOn,
        width: double.infinity,
        isLoading: context.watch<UserInvitationAccessContactsState>().isLoading,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return PaddedContent(
      child: Column(
        children: [
          _buildTurnOnButton(context),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationTemplatePage(
      // Включить доступ к контактам?
      header: L10n.of(context)!.turnOnAccessToContacts,

      // Включите доступ к вашему списку контактов, чтобы найти ваших друзей и знакомых.
      subtitle: L10n.of(context)!.turnOnAccessToFind,

      content: _buildContent(context),
      onSkip: _replaceWithMainPage,
    );
  }
}
