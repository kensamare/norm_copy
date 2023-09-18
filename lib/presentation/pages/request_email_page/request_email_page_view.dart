// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/registration_request_page/state/registration_request_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/presentation/global/error_message/error_message.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/registration_template_page/registration_template_page.dart';

class RequestEmailPageView extends StatelessWidget {
  const RequestEmailPageView({super.key});

  AppRouter get router => service<AppRouter>();

  Widget _buildNextButton(BuildContext context) {
    return Observer(
      builder: (context) => NButton(
        onPressed: () async {
          final RegistrationRequestState state = context.read<RegistrationRequestState>();
          final bool result = await state.requestSession();

          if (result) {
            // ignore: use_build_context_synchronously
            FocusScope.of(context).unfocus();

            // Route to speciality page.
            state.loadSpecialities();
            router.goToRequestSpecialityPage();
          }
        },
        title: L10n.of(context)!.next,
        width: double.infinity,
        active: context.watch<RegistrationRequestState>().canGoForwardToEmail &&
            !context.watch<RegistrationRequestState>().email.isBlank,
        isLoading: context.watch<RegistrationRequestState>().isLoading,
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return PaddedContent(
      child: Column(
        children: [
          NTextField(
            keyboardType: TextInputType.emailAddress,
            hintText: L10n.of(context)!.email,
            capitalization: TextCapitalization.none,
            width: double.infinity,
            onChanged: context.read<RegistrationRequestState>().setEmail,
            autofocus: true,
          ),
          SizedBox(height: 40.h),
          _buildNextButton(context),
        ],
      ),
    );
  }

  Widget _buildErrors(BuildContext context) {
    return Observer(
      builder: (context) => ErrorMessage(
        message: errorMessagesLocalized(context, context.watch<RegistrationRequestState>().formErrors),
      ),
      warnWhenNoObservables: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationTemplatePage(
      // Как связаться с вами?
      header: L10n.of(context)!.howToContactYou,

      content: _buildForm(context),
      errors: _buildErrors(context),
    );
  }
}
