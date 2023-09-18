// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/career/career.dart';
import 'package:norm/domain/models/create_entity_result/create_entity_delete_result.dart';
import 'package:norm/domain/models/create_entity_result/create_entity_result.dart';
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/internal/page_providers/edit_speciality_page/states/edit_speciality_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/app_bar/n_app_bar.dart';
import 'package:norm/presentation/global/career_wrapper/career_wrapper.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/n_date_field/n_date_field.dart';
import 'package:norm/presentation/global/n_dropdown/n_dropdown.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';

class EditSpecialityMainInformationPageView extends StatefulWidget {
  const EditSpecialityMainInformationPageView({super.key});

  @override
  State<EditSpecialityMainInformationPageView> createState() => _EditSpecialityMainInformationPageViewState();
}

class _EditSpecialityMainInformationPageViewState extends State<EditSpecialityMainInformationPageView> {
  final TextEditingController _specController = TextEditingController();

  AppRouter get router => service<AppRouter>();

  void pickBrand(BuildContext context) async {
    final EditSpecialityState state = context.read<EditSpecialityState>();
    final CreateEntityResult<Career?>? result = await service<AppRouter>().showCareerPopup(
      context,
      career: state.career,
      canDelete: state.career != null,
      includePeriod: false,
      includeDescription: false,
    );

    if (result?.result != null) {
      state.setCareer(result!.result);
    }

    if (result is CreateEntityDeleteResult) {
      state.setCareer(null);
    }
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return NAppBar(
      title: L10n.of(context)!.mainInformation,
    );
  }

  Widget _buildSpeciality(BuildContext context, {required Speciality speciality}) {
    final EditSpecialityState state = context.read<EditSpecialityState>();

    return InkWell(
      onTap: () {
        state.setSpecialityTitle(null);
        state.setSpeciality(speciality);

        _specController.value = TextEditingValue(
          text: speciality.title,
          selection: TextSelection.collapsed(offset: speciality.title.length),
        );
      },
      child: Ink(
        height: 48.h,
        child: PaddedContent(
          child: Row(
            children: [
              SvgPicture.network(speciality.icon),
              SizedBox(width: 16.w),
              Text(
                speciality.title,
                style: NTypography.golosRegular14,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialityField(BuildContext context) {
    return Observer(
      builder: (context) {
        final EditSpecialityState state = context.watch<EditSpecialityState>();

        return NTextField(
          initialValue: state.spec?.title ?? state.specialityTitle,
          controller: _specController,
          hintText: L10n.of(context)!.speciality,
          width: double.infinity,
          onChanged: (value) {
            state.setSpeciality(null);
            state.setSpecialityTitle(value);

            state.loadSpecialities(value);
          },
          suggestions: state.spec == null ? state.suggestedSpecs : [],
          suggestionsBuilder: (index) => _buildSpeciality(
            context,
            speciality: state.suggestedSpecs.elementAt(index),
          ),
        );
      },
    );
  }

  Widget _buildLevelField(BuildContext context) {
    return Observer(
      builder: (context) {
        final EditSpecialityState state = context.watch<EditSpecialityState>();

        return NDropdown(
          width: double.infinity,
          value: state.level,
          onChanged: (value) => state.setLevel(value),
          items: SpecialityLevel.values
              .map(
                (e) => NDropdownItem(title: specialityLevel(context, e), value: e),
              )
              .toList(),
          hint: 'Уровень',
        );
      },
    );
  }

  Widget _buildDateField(BuildContext context) {
    final EditSpecialityState state = context.watch<EditSpecialityState>();

    return NDateField(
      hint: 'Начало',
      onChanged: state.setFrom,
      initialDate: state.from,
    );
  }

  Widget _buildCareer(BuildContext context) {
    return CareerWrapper(
      career: context.read<EditSpecialityState>().career!,
      onEdit: () => pickBrand(context),
    );
  }

  Widget _buildLinkCompanyButton(BuildContext context) {
    return Observer(
      builder: (context) {
        final EditSpecialityState state = context.watch<EditSpecialityState>();

        if (state.career != null) {
          return _buildCareer(context);
        }

        return GestureDetector(
          onTap: () => pickBrand(context),
          child: Row(
            children: [
              NIcon(NIcons.link),
              SizedBox(width: 16.w),
              Text('Привязать компанию', style: NTypography.golosRegular14),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Container(
      height: 120.h,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Observer(
          builder: (context) {
            final EditSpecialityState state = context.watch<EditSpecialityState>();

            return NButton(
              isLoading: state.isSaving,
              active: state.canSave,
              width: MediaQuery.of(context).size.width - 2 * NConstants.sidePadding.w,
              onPressed: () async {
                final Speciality? speciality = await state.save();

                // Close current screen.
                if (speciality != null) await service<AppRouter>().pop(speciality);
              },
              title: L10n.of(context)!.save,
            );
          },
        ),
      ),
    );
  }

  Widget _buildDescriptionField(BuildContext context) {
    final EditSpecialityState state = context.read<EditSpecialityState>();

    return NTextField(
      initialValue: state.description,
      onChanged: state.setDescription,
      width: double.infinity,
      hintText: L10n.of(context)!.addDescription,
      maxLines: 5,
    );
  }

  Widget _buildContent(BuildContext context) {
    final EditSpecialityState state = context.read<EditSpecialityState>();

    return Stack(
      // fit: StackFit.expand,
      alignment: Alignment.bottomCenter,
      children: [
        PaddedContent(
          child: Column(
            children: [
              SizedBox(height: 24.h),
              _buildSpecialityField(context),
              SizedBox(height: 20.h),
              _buildLevelField(context),
              SizedBox(height: 20.h),
              _buildDateField(context),
              SizedBox(height: 20.h),
              _buildDescriptionField(context),
              if (state.speciality.type == SpecialityType.work) ...[
                SizedBox(height: 40.h),
                _buildLinkCompanyButton(context),
              ],
            ],
          ),
        ),
        _buildSaveButton(context),
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
