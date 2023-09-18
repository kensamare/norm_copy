// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/animal/animal.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/animal_wrapper/animal_wrapper.dart';

class ExtendedInformationAnimals extends StatelessWidget {
  const ExtendedInformationAnimals({
    super.key,
    this.animals = const [],
  });

  final List<Animal> animals;

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Животные', style: NTypography.rfDewiBold20),
        SizedBox(height: 16.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => AnimalWrapper(
            animal: animals.elementAt(index),
          ),
          itemCount: animals.length,
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
