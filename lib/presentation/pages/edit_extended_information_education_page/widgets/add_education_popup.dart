// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/education/education.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field.dart';

class AddEducationPopup extends StatefulWidget {
  const AddEducationPopup({
    super.key,
    this.education,
  });

  final Education? education;

  @override
  State<AddEducationPopup> createState() => _AddEducationPopupState();
}

class _AddEducationPopupState extends State<AddEducationPopup> {
  static final DateTime startDate = DateTime.fromMillisecondsSinceEpoch(0);
  static final DateTime endDate = DateTime.now().add(
    const Duration(days: 6 * 365),
  );

  final TextEditingController _yearController = TextEditingController();

  int? id;

  /// Custom title of brand.
  String? title;

  /// User position at chosen brand.
  String? faculty;

  /// User career description.
  int? year;

  /// Can add this language.
  bool get canAdd => !title.isBlank && !faculty.isBlank && year != null;

  @override
  void initState() {
    if (widget.education != null) {
      final Education education = widget.education!;

      id = education.id;
      title = education.title;
      faculty = education.faculty;
      year = education.year;

      _yearController.value = TextEditingValue(text: '$year г');
    }

    super.initState();
  }

  void addEducation() {
    if (!canAdd) return;

    /// Chosen education model.
    final Education education = Education(
      id: id,
      title: title!,
      faculty: faculty!,
      year: year!,
    );
    Navigator.of(context).pop(education);
  }

  void pickYear() async {
    final DateTime? date =
        await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: startDate, lastDate: endDate);

    if (date != null) {
      setState(() => year = date.year);
      _yearController.value = TextEditingValue(text: '$year г.');
    }
  }

  Widget _buildSaveButton(BuildContext context) {
    return NButton(
      onPressed: addEducation,
      title: 'Добавить',
      width: double.infinity,
      active: canAdd,
    );
  }

  Widget _buildTitleField(BuildContext context) {
    return NTextField(
      initialValue: title,
      onChanged: (value) => setState(() => title = value),
      hintText: 'Учебное заведение',
      width: double.infinity,
    );
  }

  Widget _buildFacultyField(BuildContext context) {
    return NTextField(
      initialValue: faculty,
      onChanged: (value) => setState(() => faculty = value),
      hintText: 'Специальность',
      width: double.infinity,
    );
  }

  Widget _buildDateField(BuildContext context) {
    return NTextField(
      controller: _yearController,
      onTap: pickYear,
      hintText: 'Год окончания',
      width: double.infinity,
      suffix: NIcon(NIcons.calendar),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardSizeProvider(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
        child: Column(
          children: [
            _buildTitleField(context),
            SizedBox(height: 20.h),
            _buildFacultyField(context),
            SizedBox(height: 20.h),
            _buildDateField(context),
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
