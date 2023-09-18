// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/page_providers/edit_profile_page/states/edit_profile_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/app_bar/n_app_bar.dart';
import 'package:norm/presentation/global/divider/n_horizontal_divider.dart';
import 'package:norm/presentation/global/pick_image_popup/state/pick_image_state.dart';
import 'package:norm/presentation/global/speciality_wrapper_large/speciality_wrapper_large.dart';
import 'package:norm/presentation/global/user_avatar/user_avatar.dart';
import 'package:norm/presentation/pages/edit_profile_page/widgets/edit_profile_section.dart';

class EditProfilePageView extends StatelessWidget {
  const EditProfilePageView({super.key});

  AppRouter get router => service<AppRouter>();

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return NAppBar(
      title: L10n.of(context)!.editProfile,
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Observer(
      builder: (context) {
        final EditProfileState state = context.watch<EditProfileState>();
        final User? user = state.user;

        if (user == null) return const SizedBox.shrink();

        return GestureDetector(
          onTap: () async {
            final PickImageResult result = await router.showPickImagePopup(context, canDelete: false);
            state.handleImagePickResult(result);
          },
          child: Column(
            children: [
              UserAvatar(imageUrl: user.avatar250, size: 80.r),
              SizedBox(height: 8.h),
              Text(
                'Редактировать',
                style: NTypography.golosRegular16,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFillProfileProgress(BuildContext context) {
    /// Progress widget width.
    final double width = MediaQuery.of(context).size.width - 2 * NConstants.sidePadding.w;

    return Observer(
      builder: (context) {
        final EditProfileState state = context.watch<EditProfileState>();
        final User? user = state.user;

        if (user == null) return const SizedBox.shrink();
        if (user.filledProfile == 100) return const SizedBox.shrink();

        final Map<String, Function> hints = {
          if (user.specs.isEmpty) 'Укажите специальность': () => router.goToEditSpecialitiesPage(),
          if (user.contacts.isEmpty) 'Укажите контакты': () => router.goToEditContactsPage(),
          if (user.languages.isEmpty) 'Укажите языки': () => router.goToEditLanguagesPage(),
          if (user.educations.isEmpty) 'Укажите образование': () => router.goToEditEducationPage(),
          if (user.hobbies.isEmpty) 'Укажите интересы': () => router.goToEditHobbyPage(),
        };

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
          child: Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 20.h,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: NColors.gray3,
                        border: Border.all(width: 1.r, color: NColors.gray2),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: SizedBox(
                        width: width,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 20.h,
                            width: width * (user.filledProfile / 100),
                            decoration: const BoxDecoration(
                              color: NColors.greenPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'Заполнено на ${user.filledProfile}%',
                  style: NTypography.golosRegular16.copyWith(color: NColors.greenPrimary),
                ),
                if (hints.isNotEmpty) ...[
                  SizedBox(height: 16.h),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: NColors.gray4,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Подсказки:',
                            style: NTypography.golosRegular16.copyWith(color: NColors.gray),
                          ),
                          SizedBox(height: 8.h),
                          Builder(
                            builder: (context) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => GestureDetector(
                                  onTap: () => hints.values.elementAt(index).call(),
                                  child: Text(
                                    '${index + 1}. ${hints.keys.elementAt(index)}',
                                    style: NTypography.golosRegular16.copyWith(color: NColors.bluePrimary),
                                  ),
                                ),
                                itemCount: hints.length,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSmartImport(BuildContext context) {
    return EditProfileSection(
      title: 'Умный импорт',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
        child: Text(
          'Текст, о том как это работает и для чего это',
          style: NTypography.golosRegular16.copyWith(color: NColors.gray),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 32.h),
        _buildAvatar(context),
        SizedBox(height: 16.h),
        _buildFillProfileProgress(context),
        // Container(
        //   color: NColors.gray2,
        //   height: 1.r,
        //   width: MediaQuery.of(context).size.width - 2 * NConstants.sidePadding.w,
        // ),
        // _buildSmartImport(context),
      ],
    );
  }

  Widget _buildMainInformation(BuildContext context) {
    return EditProfileSection(
      title: L10n.of(context)!.mainInformation,
      onTap: () => router.goToEditMainInformationPage(),
    );
  }

  Widget _buildMainPhoneNumber(BuildContext context) {
    return EditProfileSection(
      title: L10n.of(context)!.mainPhoneNumber,
      onTap: () => router.goToEditPhoneNumberPage(),
    );
  }

  Widget _buildContacts(BuildContext context) {
    return EditProfileSection(
      title: L10n.of(context)!.contacts,
      onTap: () => router.goToEditContactsPage(),
    );
  }

  Widget _buildSpecialities(BuildContext context) {
    return EditProfileSection(
      title: L10n.of(context)!.specialities,
      onTap: () => router.goToEditSpecialitiesPage(),
      child: Observer(
        builder: (context) => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return SpecialityWrapperLarge(
              speciality: context.watch<EditProfileState>().user!.specs.elementAt(index),
              showIcon: false,
            );
          },
          itemCount: context.watch<EditProfileState>().user?.specs.length,
        ),
      ),
    );
  }

  Widget _buildPortfolio(BuildContext context) {
    return EditProfileSection(
      title: L10n.of(context)!.portfolio,
      onTap: () => router.goToEditPortfolioPage(),
    );
  }

  Widget _buildShop(BuildContext context) {
    return EditProfileSection(
      title: L10n.of(context)!.shop,
      onTap: () => router.goToEditShopPage(),
    );
  }

  Widget _buildExtendedInformation(BuildContext context) {
    return EditProfileSection(
      onTap: () => router.goToEditExtendedInformationPage(),
      title: L10n.of(context)!.extendedInformation,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
        child: Text(
          'Мотивационный текст максимально 2 строки отивационный текст',
          style: NTypography.golosRegular16.copyWith(color: NColors.gray),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final List<Widget> widgets = [
      _buildHeader(context),
      _buildMainInformation(context),
      _buildMainPhoneNumber(context),
      _buildContacts(context),
      _buildSpecialities(context),
      _buildPortfolio(context),
      _buildShop(context),
      _buildExtendedInformation(context),
    ];

    return SafeArea(
      child: ListView.separated(
        itemBuilder: (context, index) => widgets[index],
        separatorBuilder: (_, __) => NHorizontalDivider(height: 1.r),
        itemCount: widgets.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildContent(context),
    );
  }
}
