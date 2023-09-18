// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/animal/animal.dart';
import 'package:norm/internal/page_providers/edit_extended_information_page/states/edit_extended_information_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/animal_wrapper/animal_wrapper.dart';
import 'package:norm/presentation/global/app_bar/n_app_bar.dart';
import 'package:norm/presentation/global/confirm_action_popup/confirm_action_popup.dart';
import 'package:norm/presentation/global/confirm_action_popup/widgets/confirm_action.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/pages/edit_extended_information_animals_page/widgets/add_animals_popup.dart';

class EditExtendedInformationAnimalsPageView extends StatelessWidget {
  const EditExtendedInformationAnimalsPageView({super.key});

  void openAnimalsPopup(BuildContext context, [Animal? editAnimal]) async {
    final EditExtendedInformationState state = context.read<EditExtendedInformationState>();
    final Animal? animal = await service<AppRouter>().showBottomSheet(
      context,
      Observer(builder: (context) {
        final EditExtendedInformationState state = context.watch<EditExtendedInformationState>();

        return AddAnimalsPopup(
          animal: editAnimal,
          onNeedAnimalSearch: state.searchAnimals,
          suggestedAnimals: state.suggestedAnimals,
          onNeedAnimalTypeSearch: state.searchAnimalTypes,
          suggestedAnimalTypes: state.suggestedAnimalTypes,
        );
      }),
    );

    if (animal != null) {
      state.addAnimal(animal);
    }
  }

  void openDeletePopup(BuildContext context, Animal animal) {
    final EditExtendedInformationState state = context.read<EditExtendedInformationState>();

    service<AppRouter>().showBottomSheet(
      context,
      ConfirmActionPopup(
        title: 'Вы уверены, что хотите удалить животное?',
        confirmWidget: ConfirmAction(
          title: 'Удалить',
          onTap: () {
            state.deleteAnimal(animal);
            AutoRouter.of(context).pop();
          },
        ),
        cancelWidget: ConfirmAction(title: 'Отмена', inverted: true),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return NAppBar(
      title: L10n.of(context)!.animals,
      actions: [
        _buildAddButton(context),
      ],
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () => openAnimalsPopup(context),
      child: NIcon(NIcons.add),
    );
  }

  Widget _buildEmptyAnimals(BuildContext context) {
    return GestureDetector(
      onTap: () => openAnimalsPopup(context),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24.h),
            Container(
              height: 48.r,
              width: 48.r,
              decoration: const BoxDecoration(color: NColors.gray2, shape: BoxShape.circle),
              child: Center(
                child: NIcon(NIcons.add, size: 20.r),
              ),
            ),
            SizedBox(height: 16.h),
            Text(L10n.of(context)!.add, style: NTypography.golosRegular14),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Observer(
      builder: (context) {
        final EditExtendedInformationState state = context.watch<EditExtendedInformationState>();

        if (state.user == null) return const SizedBox.shrink();

        if (state.user!.animals.isEmpty) {
          return _buildEmptyAnimals(context);
        }

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w, vertical: 16.h),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final Animal animal = state.user!.animals.elementAt(index);

            return AnimalWrapper(
              onEdit: () => openAnimalsPopup(context, animal),
              onDelete: () => openDeletePopup(context, animal),
              animal: animal,
            );
          },
          itemCount: state.user!.animals.length,
          separatorBuilder: (_, __) => SizedBox(
            height: 48.h,
            child: Center(
              child: Container(height: 1.r, color: NColors.gray2),
            ),
          ),
        );
      },
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
