// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/user_invitation_form_page/state/user_invitation_form_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/registration_template_page/registration_template_page.dart';
import 'package:norm/presentation/global/user_information_form/user_information_form.dart';

class UserInvitationFormPageView extends StatelessWidget {
  const UserInvitationFormPageView({Key? key}) : super(key: key);

  AppRouter get router => service<AppRouter>();

  Widget _buildNextButton(BuildContext context) {
    return Observer(
      builder: (context) {
        final UserInvitationFormState state = context.watch<UserInvitationFormState>();

        return NButton(
          onPressed: () => router.goToInvitationRegistrationPage(),

          // Далее.
          title: L10n.of(context)!.next,
          width: double.infinity,
          active: state.canGoForwardFirst,
          isLoading: state.isLoading,
        );
      },
    );
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      children: [
        Observer(
          builder: (context) {
            final UserInvitationFormState state = context.watch<UserInvitationFormState>();

            return UserInformationForm(
              name: state.name,
              surname: state.surname,
              onChangedName: state.setName,
              onChangedSurname: state.setSurname,
              onPickImageResult: state.handleImagePickResult,
              image: state.avatar,
              isLoadingImage: state.isLoadingImage,
            );
          },
        ),
        SizedBox(height: 40.h),
        _buildNextButton(context),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return PaddedContent(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildForm(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationTemplatePage(
      // Как вас зовут?
      header: L10n.of(context)!.whatIsYourName,
      content: _buildContent(context),
    );
  }
}
