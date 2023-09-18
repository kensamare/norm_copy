// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/internal/page_providers/edit_speciality_page/states/edit_speciality_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/app_bar/n_app_bar.dart';
import 'package:norm/presentation/global/confirm_action_popup/confirm_action_popup.dart';
import 'package:norm/presentation/global/confirm_action_popup/widgets/confirm_action.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/pick_image_popup/state/pick_image_state.dart';
import 'package:norm/presentation/global/user_avatar/user_avatar.dart';

class EditSpecialityPageView extends StatelessWidget {
  const EditSpecialityPageView({super.key});

  AppRouter get router => service<AppRouter>();

  void openDeletePopup(BuildContext context) => router.showBottomSheet(
        context,
        ConfirmActionPopup(
          title: 'Вы уверены,\nчто хотите удалить\nстраницу специальности?',
          confirmWidget: ConfirmAction(
            onTap: () async {
              final bool result = await context.read<EditSpecialityState>().delete();

              if (result) service<AppRouter>().popUntilRoot();
            },
            title: 'Да, удалить',
            alert: true,
          ),
          cancelWidget: ConfirmAction(title: 'Отмена'),
        ),
      );

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final EditSpecialityState state = context.read<EditSpecialityState>();

    return NAppBar(
      title: 'Изменить',
      popValue: state.speciality,
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Observer(
      builder: (context) {
        final EditSpecialityState state = context.watch<EditSpecialityState>();
        final Speciality speciality = state.speciality;

        return GestureDetector(
          onTap: () async {
            final PickImageResult result = await router.showPickImagePopup(context, canDelete: false);
            state.handleImagePickResult(result);
          },
          child: Center(
            child: Column(
              children: [
                UserAvatar(imageUrl: speciality.avatar250 ?? speciality.avatar, size: 64.r),
                SizedBox(height: 12.h),
                Text(
                  'Редактировать',
                  style: NTypography.golosRegular16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        height: 56.h,
        child: PaddedContent(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: NTypography.golosMedium16),
              NIcon(NIcons.arrow_right_2, color: NColors.black),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSections(BuildContext context) {
    final EditSpecialityState state = context.read<EditSpecialityState>();

    final List<Widget> items = [
      _buildSection(
        context,
        title: L10n.of(context)!.mainInformation,
        onTap: () async {
          final Speciality? speciality = await router.goToEditSpecialityMainInformationPage();

          if (speciality != null) {
            state.updateSpeciality(speciality);
          }
        },
      ),
      _buildSection(
        context,
        title: L10n.of(context)!.contacts,
        onTap: router.goToEditSpecialityContactsPage,
      ),
      _buildSection(
        context,
        title: L10n.of(context)!.portfolio,
        onTap: () => router.goToEditPortfolioPage(speciality: state.speciality),
      ),
      _buildSection(
        context,
        title: L10n.of(context)!.shop,
        onTap: () => router.goToEditShopPage(speciality: state.speciality),
      ),
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => items.elementAt(index),
      separatorBuilder: (_, __) => Container(height: 1.r, color: NColors.gray2),
      itemCount: items.length,
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return Container(
      height: 120.h,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Observer(
          builder: (context) {
            final EditSpecialityState state = context.watch<EditSpecialityState>();

            return NButton(
              isLoading: state.isDeleting,
              // active: state.canSave,
              width: MediaQuery.of(context).size.width - 2 * NConstants.sidePadding.w,
              onPressed: () => openDeletePopup(context),
              title: 'Удалить',
              inverted: true,
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            SizedBox(height: 16.h),
            _buildAvatar(context),
            SizedBox(height: 16.h),
            _buildSections(context),
          ],
        ),
        _buildDeleteButton(context),
      ],
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
