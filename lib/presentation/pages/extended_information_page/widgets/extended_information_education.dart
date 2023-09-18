// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/education/education.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/education_wrapper/education_wrapper.dart';

class ExtendedInformationEducation extends StatelessWidget {
  const ExtendedInformationEducation({
    super.key,
    this.education = const [],
  });

  final List<Education> education;

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Образование', style: NTypography.rfDewiBold20),
        SizedBox(height: 16.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => EducationWrapper(
            education: education.elementAt(index),
          ),
          itemCount: education.length,
          separatorBuilder: (_, __) => SizedBox(height: 16.h),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: _buildContent(context),
      ),
    );
  }
}
