// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/user_connect_telegram_and_phone_page/state/connect_telegram_and_phone_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/registration_template_page/registration_template_page.dart';
import 'package:norm/presentation/pages/user_connect_telegram_and_phone_page/widgets/add_phone_number_button.dart';
import 'package:norm/presentation/pages/user_connect_telegram_and_phone_page/widgets/connect_telegram_button.dart';

class UserConnectTelegramAndPhonePageView extends StatelessWidget {
  const UserConnectTelegramAndPhonePageView({
    super.key,
    this.invitation = false,
  });

  /// Went after invitation or request. If after request, then skip routes to request confirmation page.
  final bool invitation;

  AppRouter get router => service<AppRouter>();

  void goNext() {
    if (invitation) {
      router.replaceWithInvitationAccessContactsPage();
    } else {
      router.replaceWithRequestConfirmationPage();
    }
  }

  Widget _buildTelegramButton(BuildContext context) {
    return ConnectTelegramButton(
      onPressed: () async {
        final ConnectTelegramAndPhoneState state = context.read<ConnectTelegramAndPhoneState>();
        state.connectTelegram();

        /// Await for user to connect telegram.
        await asyncWhen((_) => state.connectedTelegram);
        goNext();
      },
    );
  }

  Widget _buildAddPhoneNumberButton(BuildContext context) {
    return AddPhoneNumberButton(
      onPressed: () async {
        final ConnectTelegramAndPhoneState state = context.read<ConnectTelegramAndPhoneState>();
        final bool result = await router.goToRegistrationPhoneConfirmationPage() ?? false;

        // Set connected phone as true to hide the option.
        if (result) {
          state.connectedPhone = true;
        }

        // If user connected both phone number and telegram then he automatically goes next.
        if (result && state.connectedTelegram) goNext();
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return PaddedContent(
      child: Observer(
        builder: (context) => Column(
          children: [
            if (!context.watch<ConnectTelegramAndPhoneState>().connectedPhone) ...[
              _buildAddPhoneNumberButton(context),
              SizedBox(height: 16.h),
            ],
            if (!context.watch<ConnectTelegramAndPhoneState>().connectedTelegram) ...[
              _buildTelegramButton(context),
            ],
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationTemplatePage(
      onSkip: goNext,
      // Чтобы было проще вас найти и порекомендовать.
      header: L10n.of(context)!.toFindAndRecommendYou,
      content: _buildContent(context),
    );
  }
}
