// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.onChanged,
  });

  /// On changed search callback.
  final Function(String) onChanged;

  Widget _buildSearchIcon(BuildContext context) {
    return NIcon(NIcons.search);
  }

  @override
  Widget build(BuildContext context) {
    return NTextField(
      onChanged: onChanged,

      // Поиск.
      prefix: _buildSearchIcon(context),
      hintText: L10n.of(context)!.search,
      height: 48.h,
      width: double.infinity,
      borderRadius: BorderRadius.circular(48.r),
    );
  }
}
