// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/karma_wrapper/karma_wrapper.dart';

class ProfilePageKarmaPoints extends StatelessWidget {
  const ProfilePageKarmaPoints({
    super.key,
    this.karmaLevel = 0,
    this.karmaFine = 0,
    this.karmaFineNeed = 1,
    this.karmaMultiplier = 0,
    this.karmaPoints = 0,
    this.karmaPointsNeed = 1,
  });

  /// User karma level.
  final int karmaLevel;

  /// Karma points.
  final int karmaPoints;

  /// Karma points need.
  final int karmaPointsNeed;

  /// Karma fine.
  final int karmaFine;

  /// Karma fine need.
  final int karmaFineNeed;

  /// Karma multiplier.
  final double karmaMultiplier;

  Widget _buildKarmaMultiplier(BuildContext context) {
    return Container(
      height: 40.r,
      width: 40.r,
      decoration: BoxDecoration(
        color: NColors.gray3,
        shape: BoxShape.circle,
        border: Border.all(color: NColors.gray2, width: 0.5.r),
      ),
      child: Center(
        child: Text(
          karmaMultiplier.toStringAsPrecision(2),
          style: NTypography.golosMedium12.copyWith(color: NColors.bluePrimary),
        ),
      ),
    );
  }

  Widget _buildKarmaInformation(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => service<AppRouter>().goToKarmaPage(),
      child: KarmaWrapper(
        karmaFine: karmaFine,
        karmaFineNeed: karmaFineNeed,
        karmaLevel: karmaLevel,
        karmaPoints: karmaPoints,
        karmaPointsNeed: karmaPointsNeed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
        child: Row(
          children: [
            Expanded(
              child: _buildKarmaInformation(context),
            ),
            SizedBox(width: 12.w),
            _buildKarmaMultiplier(context),
          ],
        ),
      ),
    );
  }
}
