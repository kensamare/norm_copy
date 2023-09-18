// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/interfaces/profile.dart';
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/speciality_wrapper_large/speciality_wrapper_large.dart';

class ProfilePageSpecialities extends StatelessWidget {
  const ProfilePageSpecialities({
    super.key,
    this.specs = const [],
    this.profile,
  });

  /// User speciailities.
  final List<Speciality> specs;

  /// Parent profile.
  final Profile? profile;

  Widget _buildAddSpecs(BuildContext context) {
    return InkWell(
      onTap: () => service<AppRouter>().goToEditSpecialitiesPage(),
      child: Ink(
        height: 96.h,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
            child: Row(
              children: [
                Container(
                  height: 48.r,
                  width: 48.r,
                  decoration: const BoxDecoration(color: NColors.gray2, shape: BoxShape.circle),
                  child: Center(
                    child: NIcon(NIcons.add, size: 20.r),
                  ),
                ),
                SizedBox(width: 16.w),
                Text(L10n.of(context)!.addSpeciality, style: NTypography.golosRegular14),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpeciality(BuildContext context, {required Speciality spec}) {
    return SpecialityWrapperLarge(
      speciality: spec,
      profile: profile,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (specs.isEmpty) {
      return _buildAddSpecs(context);
    }

    return SizedBox(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildSpeciality(
          context,
          spec: specs.elementAt(index),
        ),
        itemCount: specs.length,
      ),
    );
  }
}
