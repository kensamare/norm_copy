// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:norm/domain/models/brand/brand.dart';
import 'package:norm/domain/models/career/career.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/user_avatar/user_avatar.dart';

class AddCareerPopup extends StatefulWidget {
  const AddCareerPopup({
    super.key,
    this.career,
    this.suggestedBrands = const [],
    this.onNeedCompanySearch,
  });

  final Career? career;

  /// Need company search callback.
  final Function(String)? onNeedCompanySearch;

  /// Suggested brands.
  final List<Brand> suggestedBrands;

  @override
  State<AddCareerPopup> createState() => _AddCareerPopupState();
}

class _AddCareerPopupState extends State<AddCareerPopup> {
  static final DateTime startDate = DateTime.fromMillisecondsSinceEpoch(0);
  static final DateTime endDate = DateTime.now();

  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _periodController = TextEditingController();

  /// Chosen brand model.
  Brand? brand;

  /// Custom title of brand.
  String? customTitle;

  /// User position at chosen brand.
  String? position;

  /// User career description.
  String? description;

  /// Working period in the company.
  DateTimeRange? range;

  /// Can add this language.
  bool get canAdd {
    if (brand == null && customTitle.isBlank) return false;

    return !position.isBlank && range != null;
  }

  void setPeriodValue() {
    if (range == null) return;

    final String endDate = range!.end.year == DateTime.now().year ? 'по настоящее время' : '${range!.end.year}';
    _periodController.value = TextEditingValue(text: '${range!.start.year} г.- $endDate');
  }

  @override
  void initState() {
    if (widget.career != null) {
      final Career career = widget.career!;

      brand = career.brand;
      if (brand != null) {
        _brandController.value = TextEditingValue(
          text: career.brand!.title,
          selection: TextSelection.collapsed(offset: brand!.title.length),
        );
      }

      position = career.position;
      description = career.description;

      range = DateTimeRange(
        start: career.from ?? endDate,
        end: career.to ?? endDate,
      );

      setPeriodValue();
    }

    super.initState();
  }

  void addCareer() {
    if (!canAdd) return;

    /// Chosen career model.
    final Career career = Career(
      position: position!,
      description: description ?? '',
      brand: brand,
      customTitle: customTitle,
      from: range!.start,
      to: range!.end.difference(endDate).inDays == 0 ? null : range!.end,
    );
    Navigator.of(context).pop(career);
  }

  void handleBrandTitle(String value) {
    setState(() {
      customTitle = value;
      brand = null;
    });

    widget.onNeedCompanySearch?.call(value);
  }

  void pickDateTimeRange() async {
    final DateTimeRange? range = await showDateRangePicker(context: context, firstDate: startDate, lastDate: endDate);

    if (range != null) {
      setState(() => this.range = range);

      setPeriodValue();
    }
  }

  Widget _buildSuggestedBrand(BuildContext context, {required Brand brand}) {
    return InkWell(
      onTap: () {
        setState(() {
          customTitle = null;
          this.brand = brand;
        });

        _brandController.value = TextEditingValue(
          text: brand.title,
          selection: TextSelection.collapsed(offset: brand.title.length),
        );
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
    return NButton(
      onPressed: addCareer,
      title: 'Добавить',
      width: double.infinity,
      active: canAdd,
    );
  }

  Widget _buildBrandField(BuildContext context) {
    return NTextField(
      controller: _brandController,
      hintText: 'Компания',
      width: double.infinity,
      onChanged: handleBrandTitle,
      suggestions: brand == null ? widget.suggestedBrands : [],
      suggestionsBuilder: (index) => _buildSuggestedBrand(
        context,
        brand: widget.suggestedBrands.elementAt(index),
      ),
    );
  }

  Widget _buildPositionField(BuildContext context) {
    return NTextField(
      initialValue: position,
      onChanged: (value) => setState(() => position = value),
      hintText: 'Должность',
      width: double.infinity,
    );
  }

  Widget _buildPeriodField(BuildContext context) {
    return NTextField(
      controller: _periodController,
      onTap: pickDateTimeRange,
      hintText: 'Выберите период',
      width: double.infinity,
      suffix: NIcon(NIcons.calendar),
    );
  }

  Widget _buildDescriptionField(BuildContext context) {
    return NTextField(
      initialValue: description,
      onChanged: (value) => setState(() => description = value),
      hintText: 'Описание',
      width: double.infinity,
      maxLines: 4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardSizeProvider(
      child: PaddedContent(
        child: Column(
          children: [
            _buildBrandField(context),
            SizedBox(height: 20.h),
            _buildPositionField(context),
            SizedBox(height: 20.h),
            _buildPeriodField(context),
            SizedBox(height: 20.h),
            _buildDescriptionField(context),
            SizedBox(height: 40.h),
            _buildSaveButton(context),
            Consumer<ScreenHeight>(
              builder: (context, value, _) => SizedBox(height: value.isOpen ? (value.keyboardHeight + 24.h) : 40.h),
            ),
          ],
        ),
      ),
    );
  }
}
