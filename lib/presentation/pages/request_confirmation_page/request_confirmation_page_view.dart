// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/registration_template_page/registration_template_page.dart';

class RequestConfirmationPageView extends StatelessWidget {
  const RequestConfirmationPageView({super.key});

  AppRouter get router => service<AppRouter>();

  Widget _buildConfirmButton(BuildContext context) {
    return NButton(
      onPressed: () => router.goToRegistrationWithInvitationCodePage(hasInvite: true),

      // У меня появился инвайт-код.
      title: L10n.of(context)!.iGotInvitation,
      width: double.infinity,
    );
  }

  Widget _buildContent(BuildContext context) {
    return PaddedContent(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildConfirmButton(context),
          SizedBox(height: 54.h),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationTemplatePage(
      // Заявка принята.
      header: L10n.of(context)!.requestAccepted,

      // Не отключайте уведомления. Мы пришлем его, как только вы получите инвайт.
      subtitle: L10n.of(context)!.dontTurnOffNotifications,

      content: _buildContent(context),
    );
  }
}
