// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/hobby/hobby.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field.dart';

class AddHobbyPopup extends StatefulWidget {
  const AddHobbyPopup({
    super.key,
    this.hobby,
    this.onNeedHobbySearch,
    this.suggestedHobbies = const [],
  });

  final Hobby? hobby;

  /// Need hobby search callback.
  final Function(String)? onNeedHobbySearch;

  /// Suggested hobby.
  final List<Hobby> suggestedHobbies;

  @override
  State<AddHobbyPopup> createState() => _AddHobbyPopupState();
}

class _AddHobbyPopupState extends State<AddHobbyPopup> {
  final TextEditingController _hobbyController = TextEditingController();

  int? id;

  int? hobbyId;

  /// Hobby title.
  String? title;

  /// Level of hobby.
  String? level;

  /// Exprience in years.
  int? years;

  /// Description about hobby.
  String? description;

  bool get canAdd {
    if (id == null && title.isBlank) return false;

    return !level.isBlank && !description.isBlank && years != null;
  }

  @override
  void initState() {
    if (widget.hobby != null) {
      final Hobby hobby = widget.hobby!;

      id = hobby.id;
      hobbyId = hobby.hobbyId;
      title = hobby.title;
      level = hobby.level;
      years = hobby.years;
      description = hobby.description;

      _hobbyController.value = TextEditingValue(
        text: title ?? '',
        selection: TextSelection.collapsed(offset: (title ?? '').length),
      );
    }

    super.initState();
  }

  void handleHobbyTitle(String value) {
    setState(() => title = value);

    widget.onNeedHobbySearch?.call(value);
  }

  void addHobby() {
    if (!canAdd) return;

    /// Chosen hobby model.
    final Hobby hobby = Hobby(
      id: id,
      hobbyId: hobbyId,
      title: title ?? '',
      level: level ?? '',
      years: years,
      description: description ?? '',
    );
    Navigator.of(context).pop(hobby);
  }

  Widget _buildSaveButton(BuildContext context) {
    return NButton(
      onPressed: addHobby,
      title: 'Добавить',
      width: double.infinity,
      active: canAdd,
    );
  }

  Widget _buildSuggestedHobby(BuildContext context, {required Hobby hobby}) {
    return InkWell(
      onTap: () {
        setState(() {
          title = null;
          id = hobby.id;
        });

        _hobbyController.value = TextEditingValue(
          text: hobby.title,
          selection: TextSelection.collapsed(offset: hobby.title.length),
        );
      },
      child: Ink(
        height: 48.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
          child: Row(
            children: [
              Text(hobby.title, style: NTypography.golosRegular14),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField(BuildContext context) {
    return NTextField(
      controller: _hobbyController,
      onChanged: handleHobbyTitle,
      hintText: 'Поиск интересов/хобби/навыки',
      width: double.infinity,
      suggestions: id == null ? widget.suggestedHobbies : [],
      suggestionsBuilder: (index) => _buildSuggestedHobby(
        context,
        hobby: widget.suggestedHobbies.elementAt(index),
      ),
    );
  }

  Widget _buildLevelField(BuildContext context) {
    return NTextField(
      initialValue: level,
      onChanged: (value) => setState(() => level = value),
      hintText: 'Уровень владения',
      width: double.infinity,
    );
  }

  Widget _buildExperienceField(BuildContext context) {
    return NTextField(
      initialValue: years == null ? null : years!.toString(),
      onChanged: (value) => setState(
        () => years = int.tryParse(value),
      ),
      hintText: 'Опыт в годах',
      width: double.infinity,
    );
  }

  Widget _buildDescriptionField(BuildContext context) {
    return NTextField(
      initialValue: description,
      onChanged: (value) => setState(() => description = value),
      hintText: 'Комментарий',
      width: double.infinity,
      maxLines: 4,
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
            _buildLevelField(context),
            SizedBox(height: 20.h),
            _buildExperienceField(context),
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
