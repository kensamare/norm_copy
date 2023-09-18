// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/edit_specialities_page/states/edit_specialities_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/app_bar/n_app_bar.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/speciality_wrapper_large/speciality_wrapper_large.dart';

class EditSpecialitiesPageView extends StatelessWidget {
  const EditSpecialitiesPageView({super.key});

  AppRouter get router => service<AppRouter>();

  void openPickSpecialityTypePopup(BuildContext context) => router.openCreateSpecialityTypePopup(context);

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () => openPickSpecialityTypePopup(context),
      child: NIcon(NIcons.add),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return NAppBar(
      title: L10n.of(context)!.specialities,
      actions: [
        _buildAddButton(context),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
            child: Text(
              'В качестве специальности может быть: твоя профессия/навык, любой из твоих личных брендов, наемная работа',
              style: NTypography.golosRegular16.copyWith(color: NColors.gray),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 24.h),
          _buildSpecialities(context),
        ],
      ),
    );
  }

  Widget _buildEmptySpecialities(BuildContext context) {
    return GestureDetector(
      onTap: () => openPickSpecialityTypePopup(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 48.r,
            width: 48.r,
            decoration: const BoxDecoration(color: NColors.gray2, shape: BoxShape.circle),
            child: Center(
              child: NIcon(NIcons.add, size: 20.r),
            ),
          ),
          SizedBox(height: 16.h),
          Text(L10n.of(context)!.addSpeciality, style: NTypography.golosRegular14),
        ],
      ),
    );
  }

  Widget _buildSpecialities(BuildContext context) {
    return Observer(
      builder: (context) {
        final EditSpecialitiesState state = context.watch<EditSpecialitiesState>();

        if (state.user == null) return const SizedBox.shrink();

        if (state.user!.specs.isEmpty) {
          return _buildEmptySpecialities(context);
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return SpecialityWrapperLarge(
              speciality: state.user!.specs.elementAt(index),
              icon: NIcon(NIcons.edit_2),
            );
          },
          itemCount: state.user!.specs.length,
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
