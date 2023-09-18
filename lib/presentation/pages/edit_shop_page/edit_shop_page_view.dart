// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/item/item.dart';
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/internal/page_providers/edit_shop_page/states/edit_shop_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/app_bar/n_app_bar.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/item_wrapper/item_wrapper.dart';
import 'package:norm/presentation/global/n_dropdown/n_dropdown.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/two_items_square_grid/two_items_square_grid.dart';
import 'package:norm/presentation/global/user_avatar/user_avatar.dart';

class EditShopPageView extends StatelessWidget {
  const EditShopPageView({super.key});

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return NAppBar(
      title: L10n.of(context)!.shop,
    );
  }

  Widget _buildSpecialityPicker(BuildContext context) {
    return Observer(
      builder: (context) {
        final EditShopState state = context.watch<EditShopState>();

        final List<NDropdownItem> items = [
          ...state.specialities.map(
            (e) => NDropdownItem(
              title: e.title,
              value: e,
              icon: UserAvatar(
                size: 32.r,
                imageUrl: e.avatar250,
              ),
            ),
          ),
          NDropdownItem(
            title: 'Создать',
            value: -1,
            icon: Container(
              height: 32.r,
              width: 32.r,
              decoration: const BoxDecoration(color: NColors.gray2, shape: BoxShape.circle),
              child: Center(
                child: NIcon(NIcons.add, size: 16.r),
              ),
            ),
          ),
        ];

        return NDropdown(
          width: double.infinity,
          hint: 'Специальность',
          items: items,
          onChanged: (value) {
            if (value is Speciality) {
              state.setSpeciality(value);
            } else if (value == -1) {
              service<AppRouter>().openCreateSpecialityTypePopup(context);
            }
          },
          value: state.speciality,
        );
      },
    );
  }

  Widget _buildEmptySpeciality(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: Text('Выберите специальность', style: NTypography.golosRegular16),
    );
  }

  Widget _buildAddItemButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final EditShopState state = context.read<EditShopState>();

        final Item? item = await service<AppRouter>().goToCreateItemPage();

        if (item != null) {
          state.addItem(item);
        }
      },
      child: SizedBox(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40.r,
                width: 40.r,
                decoration: const BoxDecoration(color: NColors.gray2, shape: BoxShape.circle),
                child: Center(
                  child: NIcon(NIcons.add, size: 16.r),
                ),
              ),
              SizedBox(height: 16.h),
              Text('Добавить', style: NTypography.golosRegular14),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItems(BuildContext context) {
    return Observer(
      builder: (context) {
        final EditShopState state = context.watch<EditShopState>();

        if (state.speciality == null) return _buildEmptySpeciality(context);

        return TwoItemsSquareGrid(
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildAddItemButton(context);
            }

            final Item item = state.items.elementAt(index - 1);

            return ItemWrapper(item: item);
          },
          itemCount: state.items.length + 1,
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 24.h),
          PaddedContent(
            child: _buildSpecialityPicker(context),
          ),
          SizedBox(height: 16.h),
          _buildItems(context),
        ],
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
