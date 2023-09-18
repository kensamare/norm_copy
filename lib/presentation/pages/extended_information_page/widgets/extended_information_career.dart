// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/career/career.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/career_wrapper/career_wrapper.dart';

class ExtendedInformationCareer extends StatelessWidget {
  const ExtendedInformationCareer({
    super.key,
    this.career = const [],
  });

  final List<Career> career;

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Карьера', style: NTypography.rfDewiBold20),
        SizedBox(height: 16.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => CareerWrapper(
            career: career.elementAt(index),
          ),
          itemCount: career.length,
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
