// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/career/career.dart';
import 'package:norm/domain/models/create_entity_result/create_entity_delete_result.dart';
import 'package:norm/domain/models/create_entity_result/create_entity_result.dart';
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/internal/page_providers/create_profession_page/states/create_profession_state.dart';
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

class CreateProfessionPageView extends StatefulWidget {
  const CreateProfessionPageView({super.key});

  @override
  State<CreateProfessionPageView> createState() => _CreateProfessionPageViewState();
}

class _CreateProfessionPageViewState extends State<CreateProfessionPageView> {
  final TextEditingController _specController = TextEditingController();

  AppRouter get router => service<AppRouter>();

  void pickBrand(BuildContext context) async {
    final CreateProfessionState state = context.read<CreateProfessionState>();
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
    return NAppBar(title: 'Новая профессия');
  }

  Widget _buildSpeciality(BuildContext context, {required Speciality speciality}) {
    final CreateProfessionState state = context.read<CreateProfessionState>();

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
        final CreateProfessionState state = context.watch<CreateProfessionState>();

        return NTextField(
          controller: _specController,
          hintText: L10n.of(context)!.speciality,
          width: double.infinity,
          onChanged: (value) {
            state.setSpeciality(null);
            state.setSpecialityTitle(value);

            state.loadSpecialities(value);
          },
          suggestions: state.speciality == null ? state.suggestedSpecs : [],
          suggestionsBuilder: (index) => _buildSpeciality(
            context,
            speciality: state.suggestedSpecs.elementAt(index),
          ),
        );
      },
    );
  }

  Widget _buildDescriptionField(BuildContext context) {
    final CreateProfessionState state = context.read<CreateProfessionState>();

    return NTextField(
      initialValue: state.description,
      onChanged: state.setDescription,
      width: double.infinity,
      hintText: L10n.of(context)!.addDescription,
      maxLines: 5,
    );
  }

  Widget _buildLevelField(BuildContext context) {
    return Observer(
      builder: (context) {
        final CreateProfessionState state = context.watch<CreateProfessionState>();

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
    final CreateProfessionState state = context.watch<CreateProfessionState>();

    return NDateField(
      hint: 'Начало',
      onChanged: state.setFrom,
    );
  }

  Widget _buildCareer(BuildContext context) {
    return CareerWrapper(
      career: context.read<CreateProfessionState>().career!,
      onEdit: () => pickBrand(context),
    );
  }

  Widget _buildLinkCompanyButton(BuildContext context) {
    return Observer(
      builder: (context) {
        final CreateProfessionState state = context.watch<CreateProfessionState>();

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
    return Observer(
      builder: (context) {
        final CreateProfessionState state = context.watch<CreateProfessionState>();

        return NButton(
          onPressed: () async {
            final Speciality? speciality = await state.createSpeciality();

            if (speciality != null) {
              router.popUntilRoot();
              router.handleSpecialityRoute(speciality);
            }
          },
          title: 'Добавить',
          width: double.infinity,
          active: state.canSave,
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return PaddedContent(
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
          SizedBox(height: 40.h),
          _buildLinkCompanyButton(context),
          SizedBox(height: 40.h),
          _buildSaveButton(context),
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
