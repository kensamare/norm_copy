// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/hobby/hobby.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/hobby_wrapper/hobby_wrapper.dart';

class ExtendedInformationHobby extends StatelessWidget {
  const ExtendedInformationHobby({
    super.key,
    this.hobbies = const [],
  });

  final List<Hobby> hobbies;

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Интересы', style: NTypography.rfDewiBold20),
        SizedBox(height: 16.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => HobbyWrapper(
            hobby: hobbies.elementAt(index),
          ),
          itemCount: hobbies.length,
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
