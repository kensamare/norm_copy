// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/brand/brand.dart';
import 'package:norm/internal/page_providers/edit_brand_page/states/edit_brand_state.dart';
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

class EditBrandPageView extends StatelessWidget {
  const EditBrandPageView({super.key});

  AppRouter get router => service<AppRouter>();

  void openDeletePopup(BuildContext context) => router.showBottomSheet(
        context,
        ConfirmActionPopup(
          title: 'Вы уверены,\nчто хотите удалить\nстраницу бренда?',
          confirmWidget: ConfirmAction(
            onTap: () async {
              final bool result = await context.read<EditBrandState>().delete();

              if (result) service<AppRouter>().popUntilRoot();
            },
            title: 'Да, удалить',
            alert: true,
          ),
          cancelWidget: ConfirmAction(title: 'Отмена'),
        ),
      );

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final EditBrandState state = context.read<EditBrandState>();

    return NAppBar(
      title: 'Изменить',
      popValue: state.brand,
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Observer(
      builder: (context) {
        final EditBrandState state = context.watch<EditBrandState>();
        final Brand brand = state.brand;

        return GestureDetector(
          onTap: () async {
            final PickImageResult result = await router.showPickImagePopup(context, canDelete: false);
            state.handleImagePickResult(result);
          },
          child: Center(
            child: Column(
              children: [
                UserAvatar(imageUrl: brand.avatar250 ?? brand.avatar, size: 64.r),
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
    final EditBrandState state = context.read<EditBrandState>();

    final List<Widget> items = [
      _buildSection(
        context,
        title: L10n.of(context)!.mainInformation,
        onTap: () async {
          final Brand? brand = await router.goToEditBrandMainInformationPage();

          if (brand != null) {
            state.updateBrand(brand);
          }
        },
      ),
      _buildSection(
        context,
        title: L10n.of(context)!.contacts,
        onTap: () async {
          final Brand? brand = await router.goToEditBrandContactsPage();

          if (brand != null) {
            state.updateBrand(brand);
          }
        },
      ),
      _buildSection(
        context,
        title: L10n.of(context)!.portfolio,
        onTap: () => router.goToEditPortfolioPage(brand: state.brand),
      ),
      _buildSection(
        context,
        title: L10n.of(context)!.shop,
        onTap: () => router.goToEditShopPage(brand: state.brand),
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
            final EditBrandState state = context.watch<EditBrandState>();

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
