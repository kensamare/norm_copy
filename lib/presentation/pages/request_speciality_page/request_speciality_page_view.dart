// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/internal/page_providers/registration_request_page/state/registration_request_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/error_message/error_message.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/registration_template_page/registration_template_page.dart';
import 'package:norm/presentation/global/search_field/search_field.dart';
import 'package:norm/presentation/global/speciality_wrapper/speciality_wrapper.dart';

class RequestSpecialityPageView extends StatelessWidget {
  const RequestSpecialityPageView({super.key});

  AppRouter get router => service<AppRouter>();

  Widget _buildNextButton(BuildContext context) {
    return PaddedContent(
      child: Observer(
        builder: (context) => NButton(
          onPressed: () async {
            final bool result = await context.read<RegistrationRequestState>().updateSpecs();

            if (result) router.goToConnectTelegramAndPhonePage(tgCode: null);
          },
          title: L10n.of(context)!.next,
          width: double.infinity,
          isLoading: context.watch<RegistrationRequestState>().isLoading,
        ),
      ),
    );
  }

  Widget _buildSpecialities(BuildContext context) {
    return SizedBox(
      height: (48 * 3).h + 16.r,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 1200.w,
          child: Observer(
            builder: (context) => Wrap(
              direction: Axis.horizontal,
              spacing: 8.r,
              runSpacing: 8.r,
              children: context
                  .watch<RegistrationRequestState>()
                  .notPickedSpecialities
                  .map(
                    (e) => SpecialityWrapper(
                      onTap: () => context.read<RegistrationRequestState>().pickSpeciality(e),
                      speciality: e,
                      isChosen: false,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChosenSpecialities(BuildContext context) {
    return Observer(
      builder: (context) => ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
        itemBuilder: (context, index) {
          final Speciality spec = context.watch<RegistrationRequestState>().pickedSpecialities.elementAt(index);

          return SpecialityWrapper(
            onTap: () => context.read<RegistrationRequestState>().removeSpeciality(spec),
            speciality: spec,
            isChosen: true,
          );
        },
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemCount: context.watch<RegistrationRequestState>().pickedSpecialities.length,
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return PaddedContent(
      child: SearchField(onChanged: context.read<RegistrationRequestState>().searchSpecialities),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        _buildSearch(context),
        SizedBox(height: 8.h),
        SizedBox(
          height: 48.h,
          child: _buildChosenSpecialities(context),
        ),
        SizedBox(height: 40.h),
        _buildSpecialities(context),
        SizedBox(height: 40.h),
        _buildNextButton(context),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildErrors(BuildContext context) {
    return Observer(
      builder: (context) => ErrorMessage(
        message: errorMessagesLocalized(context, context.watch<RegistrationRequestState>().specsErrors),
      ),
      warnWhenNoObservables: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardSizeProvider(
      child: Consumer<ScreenHeight>(
        builder: (context, res, child) {
          return RegistrationTemplatePage(
            header: res.isOpen ? null : L10n.of(context)!.chooseSpeciality,
            subtitle: res.isOpen ? null : L10n.of(context)!.helpOtherPeopleUnderstandAboutYou,
            content: _buildContent(context),
            errors: _buildErrors(context),

            /// Do not resize page when keyboard opens.
            resizeToAvoidBottomInset: true,
          );
        },
      ),
    );
  }
}
