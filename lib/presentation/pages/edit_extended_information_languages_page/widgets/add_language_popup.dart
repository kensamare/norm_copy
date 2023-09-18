// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:norm/domain/models/language/language.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/n_dropdown/n_dropdown.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';

class AddLanguagePopup extends StatefulWidget {
  const AddLanguagePopup({
    super.key,
    this.languages = const [],
    this.language,
  });

  final Language? language;

  final List<Language> languages;

  @override
  State<AddLanguagePopup> createState() => _AddLanguagePopupState();
}

class _AddLanguagePopupState extends State<AddLanguagePopup> {
  /// ID of chosen language.
  int? id;

  /// Language level of chosen language.
  LanguageLevel level = LanguageLevel.A1;

  /// Can add this language.
  bool get canAdd => id != null;

  @override
  void initState() {
    if (widget.language != null) {
      id = widget.language!.id;
      level = widget.language!.level;
    }

    super.initState();
  }

  void addLanguage() {
    if (!canAdd) return;

    /// Chosen language model.
    final Language language = Language(id: id, level: level);
    Navigator.of(context).pop(language);
  }

  Widget _buildSaveButton(BuildContext context) {
    return NButton(
      onPressed: addLanguage,
      title: 'Добавить',
      width: double.infinity,
      active: canAdd,
    );
  }

  Widget _buildLanguageDropdown(BuildContext context) {
    return NDropdown(
      width: double.infinity,
      hint: 'Выберите язык',
      value: id,
      items: widget.languages
          .map(
            (e) => NDropdownItem(icon: SvgPicture.network(e.icon), title: e.title, value: e.id),
          )
          .toList(),
      onChanged: (languageId) => setState(() => id = languageId),
    );
  }

  Widget _buildLevelDropdown(BuildContext context) {
    return NDropdown(
      width: double.infinity,
      hint: 'Выберите уровень',
      value: level,
      items: LanguageLevel.values
          .map(
            (e) => NDropdownItem(title: languageLevel(context, e), value: e),
          )
          .toList(),
      onChanged: (languageLevel) => setState(() => level = languageLevel),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PaddedContent(
      child: Column(
        children: [
          _buildLanguageDropdown(context),
          SizedBox(height: 20.h),
          _buildLevelDropdown(context),
          SizedBox(height: 40.h),
          _buildSaveButton(context),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
