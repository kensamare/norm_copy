// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/brand/brand.dart';
import 'package:norm/domain/models/career/career.dart';
import 'package:norm/domain/models/create_entity_result/create_entity_delete_result.dart';
import 'package:norm/domain/models/create_entity_result/create_entity_result.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/create_popups/career_popup/state/create_career_state.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/n_period_field/n_period_field.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/user_avatar/user_avatar.dart';

class CareerPopup extends StatefulWidget {
  const CareerPopup({
    super.key,
    this.career,
    this.canDelete = false,
    this.includePeriod = true,
    this.includeDescription = true,
  });

  final Career? career;

  /// Is delete action available.
  final bool canDelete;

  /// Include period field or not.
  final bool includePeriod;

  /// Include description field or not.
  final bool includeDescription;

  @override
  State<CareerPopup> createState() => _CareerPopupState();
}

class _CareerPopupState extends State<CareerPopup> {
  final TextEditingController _brandController = TextEditingController();

  void popWithResult(BuildContext context) {
    final CreateCareerState state = context.read<CreateCareerState>();
    if (!state.canPopWithResult) return;

    final Career? career = state.career();
    final CreateEntityResult<Career?> result = CreateEntityResult(result: career);

    AutoRouter.of(context).pop(result);
  }

  Widget _buildSuggestedBrand(BuildContext context, {required Brand brand}) {
    final CreateCareerState state = context.read<CreateCareerState>();

    return InkWell(
      onTap: () {
        state.setBrandTitle(null);
        state.setBrand(brand);

        setControllerValue(_brandController, brand.title);
      },
      child: Ink(
        height: 48.h,
        child: PaddedContent(
          child: Row(
            children: [
              UserAvatar(
                size: 32.r,
                imageUrl: brand.avatar250,
                letter: brand.title[0],
              ),
              SizedBox(width: 16.w),
              Text(brand.title, style: NTypography.golosRegular14),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Observer(
      builder: (context) {
        final CreateCareerState state = context.watch<CreateCareerState>();

        return NButton(
          onPressed: () => popWithResult(context),
          title: 'Добавить',
          width: double.infinity,
          active: state.canPopWithResult,
        );
      },
    );
  }

  Widget _buildBrandField(BuildContext context) {
    return Observer(
      builder: (context) {
        final CreateCareerState state = context.watch<CreateCareerState>();

        return NTextField(
          initialValue: widget.career?.brand?.title ?? widget.career?.customTitle,
          controller: _brandController,
          hintText: 'Компания',
          width: double.infinity,
          onChanged: (value) {
            state.setBrandTitle(value);
            state.setBrand(null);

            state.searchBrands(value);
          },
          suggestions: state.brand == null ? state.suggestedBrands : [],
          suggestionsBuilder: (index) => _buildSuggestedBrand(
            context,
            brand: state.suggestedBrands.elementAt(index),
          ),
        );
      },
    );
  }

  Widget _buildPositionField(BuildContext context) {
    final CreateCareerState state = context.read<CreateCareerState>();

    return NTextField(
      initialValue: state.position,
      onChanged: (value) => state.setPosition(value),
      hintText: 'Должность',
      width: double.infinity,
    );
  }

  Widget _buildPeriodField(BuildContext context) {
    final CreateCareerState state = context.read<CreateCareerState>();

    return NPeriodField(
      onChanged: state.setRange,
      initialRange: state.range,
    );
  }

  Widget _buildDescriptionField(BuildContext context) {
    final CreateCareerState state = context.read<CreateCareerState>();

    return NTextField(
      initialValue: state.description,
      onChanged: (value) => state.setDescription(value),
      hintText: 'Описание',
      width: double.infinity,
      maxLines: 4,
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return NButton(
      onPressed: () => AutoRouter.of(context).pop(
        CreateEntityDeleteResult<Career?>(),
      ),
      title: 'Удалить',
      width: double.infinity,
      colour: NColors.redError,
    );
  }

  Widget _buildContent(BuildContext context) {
    return KeyboardSizeProvider(
      child: PaddedContent(
        child: Column(
          children: [
            _buildBrandField(context),
            SizedBox(height: 20.h),
            _buildPositionField(context),
            if (widget.includePeriod) ...[
              SizedBox(height: 20.h),
              _buildPeriodField(context),
            ],
            if (widget.includeDescription) ...[
              SizedBox(height: 20.h),
              _buildDescriptionField(context),
            ],
            SizedBox(height: 40.h),
            _buildSaveButton(context),
            if (widget.canDelete) ...[
              SizedBox(height: 20.h),
              _buildDeleteButton(context),
            ],
            Consumer<ScreenHeight>(
              builder: (context, value, _) => SizedBox(height: value.isOpen ? (value.keyboardHeight + 24.h) : 40.h),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CreateCareerState()..initialize(widget.career),
      builder: (context, _) => _buildContent(context),
    );
  }
}
