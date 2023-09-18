// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/career/career.dart';
import 'package:norm/internal/page_providers/edit_extended_information_page/states/edit_extended_information_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/app_bar/n_app_bar.dart';
import 'package:norm/presentation/global/career_wrapper/career_wrapper.dart';
import 'package:norm/presentation/global/confirm_action_popup/confirm_action_popup.dart';
import 'package:norm/presentation/global/confirm_action_popup/widgets/confirm_action.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/pages/edit_extended_information_career_page/widgets/add_career_popup.dart';

class EditExtendedInformationCareerPageView extends StatelessWidget {
  const EditExtendedInformationCareerPageView({super.key});

  void openCareerPopup(BuildContext context, [Career? editCareer]) async {
    final EditExtendedInformationState state = context.read<EditExtendedInformationState>();
    final Career? career = await service<AppRouter>().showBottomSheet(
      context,
      Observer(
        builder: (context) {
          final EditExtendedInformationState state = context.watch<EditExtendedInformationState>();

          return AddCareerPopup(
            career: editCareer,
            onNeedCompanySearch: state.searchBrands,
            suggestedBrands: state.suggestedBrands,
          );
        },
      ),
    );

    if (career != null) {
      state.addCareer(career);
    }
  }

  void openDeletePopup(BuildContext context, Career career) {
    final EditExtendedInformationState state = context.read<EditExtendedInformationState>();

    service<AppRouter>().showBottomSheet(
      context,
      ConfirmActionPopup(
        title: 'Вы уверены, что хотите удалить карьеру?',
        confirmWidget: ConfirmAction(
          title: 'Удалить',
          onTap: () {
            state.deleteCareer(career);
            AutoRouter.of(context).pop();
          },
        ),
        cancelWidget: ConfirmAction(title: 'Отмена', inverted: true),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return NAppBar(
      title: L10n.of(context)!.career,
      actions: [
        _buildAddButton(context),
      ],
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () => openCareerPopup(context),
      child: NIcon(NIcons.add),
    );
  }

  Widget _buildEmptyCareer(BuildContext context) {
    return GestureDetector(
      onTap: () => openCareerPopup(context),
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

        if (state.user!.career.isEmpty) {
          return _buildEmptyCareer(context);
        }

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w, vertical: 16.h),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final Career career = state.user!.career.elementAt(index);

            return CareerWrapper(
              onEdit: () => openCareerPopup(context, career),
              onDelete: () => openDeletePopup(context, career),
              career: career,
            );
          },
          itemCount: state.user!.career.length,
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
