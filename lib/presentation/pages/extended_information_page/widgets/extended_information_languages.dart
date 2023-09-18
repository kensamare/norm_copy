// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/language/language.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/language_wrapper/language_wrapper.dart';

class ExtendedInformationLanguages extends StatelessWidget {
  const ExtendedInformationLanguages({
    super.key,
    this.languages = const [],
  });

  final List<Language> languages;

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Языки', style: NTypography.rfDewiBold20),
        SizedBox(height: 16.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => LanguageWrapper(
            language: languages.elementAt(index),
          ),
          itemCount: languages.length,
          separatorBuilder: (_, __) => SizedBox(height: 16.h),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: _buildContent(context),
      ),
    );
  }
}
