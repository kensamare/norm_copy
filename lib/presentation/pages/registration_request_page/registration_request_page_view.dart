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
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/presentation/global/agree_with_terms/agree_with_terms.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/registration_template_page/registration_template_page.dart';
import 'package:norm/presentation/global/user_information_form/user_information_form.dart';

class RegistrationRequestPageView extends StatelessWidget {
  const RegistrationRequestPageView({Key? key}) : super(key: key);

  AppRouter get router => service<AppRouter>();

  Widget _buildNextButton(BuildContext context) {
    return Observer(
      builder: (context) => NButton(
        onPressed: () => router.goToRequestEmailPage(),
        title: L10n.of(context)!.next,
        width: double.infinity,
        active: context.watch<RegistrationRequestState>().canGoForwardToEmail,
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return PaddedContent(
      child: Column(
        children: [
          Observer(
            builder: (context) => UserInformationForm(
              onChangedName: context.read<RegistrationRequestState>().setName,
              onChangedSurname: context.read<RegistrationRequestState>().setSurname,
              onPickImageResult: context.read<RegistrationRequestState>().handleImagePickResult,
              image: context.watch<RegistrationRequestState>().avatar,
              isLoadingImage: context.watch<RegistrationRequestState>().isLoadingImage,
            ),
          ),
          SizedBox(height: 20.h),
          AgreeWithTerms(
            onChanged: context.read<RegistrationRequestState>().setAgreedToTerms,
          ),
          SizedBox(height: 40.h),
          _buildNextButton(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationTemplatePage(
      // Оставьте заявку.
      header: L10n.of(context)!.leaveARequest,

      content: _buildForm(context),
    );
  }
}
