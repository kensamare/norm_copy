// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';

class KarmaWrapper extends StatelessWidget {
  const KarmaWrapper({
    super.key,
    this.karmaLevel = 0,
    this.karmaFine = 0,
    this.karmaFineNeed = 1,
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

  Widget _buildKarmaBarBackground(BuildContext context) {
    return Container(
      height: 13.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: const [
          BoxShadow(
            color: NColors.black,
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(0, -2),
          ),
          BoxShadow(color: NColors.white, blurRadius: 5, spreadRadius: 6),
        ],
      ),
    );
  }

  Widget _buildKarmaBarGraph(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double halfWidth = constraints.maxWidth / 2;

        final double karmaPointsP = karmaPoints / karmaPointsNeed;
        final double karmaFineP = karmaFine / karmaFineNeed;

        final double leftWidth = halfWidth * karmaFineP;
        final double rightWidth = halfWidth * karmaPointsP;

        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: halfWidth - leftWidth),
            Container(
              height: 16.h,
              width: leftWidth,
              decoration: BoxDecoration(
                color: NColors.redPrimary,
                borderRadius: BorderRadius.horizontal(left: Radius.circular(20.r)),
              ),
            ),
            Container(
              height: 16.h,
              width: rightWidth,
              decoration: BoxDecoration(
                color: NColors.greenPrimary,
                borderRadius: BorderRadius.horizontal(right: Radius.circular(20.r)),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildKarmaBarDivider(BuildContext context) {
    return Container(
      width: 1.w,
      height: 24.h,
      color: NColors.black,
    );
  }

  Widget _buildKarmaBar(BuildContext context) {
    return SizedBox(
      height: 24.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _buildKarmaBarBackground(context),
          _buildKarmaBarGraph(context),
          _buildKarmaBarDivider(context),
        ],
      ),
    );
  }

  Widget _buildKarmaValues(BuildContext context) {
    return Row(
      children: [
        Text(
          '$karmaFine/$karmaFineNeed',
          style: NTypography.golosRegular14.copyWith(color: NColors.redPrimary),
        ),
        SizedBox(width: 16.w),
        Text(
          '$karmaPoints/$karmaPointsNeed',
          style: NTypography.golosRegular14.copyWith(color: NColors.greenPrimary),
        ),
      ],
    );
  }

  Widget _buildPreviousKarmaLevel(BuildContext context) {
    return Row(
      children: [
        NIcon(NIcons.karma_up, color: NColors.gray),
        SizedBox(width: 2.w),
        Text(
          (karmaLevel - 1).toString(),
          style: NTypography.golosRegular14.copyWith(color: NColors.gray),
        ),
      ],
    );
  }

  Widget _buildNextKarmaLevel(BuildContext context) {
    return Row(
      children: [
        NIcon(NIcons.karma_up, color: NColors.gray),
        SizedBox(width: 2.w),
        Text(
          (karmaLevel + 1).toString(),
          style: NTypography.golosRegular14.copyWith(color: NColors.gray),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildPreviousKarmaLevel(context),
            _buildKarmaValues(context),
            _buildNextKarmaLevel(context),
          ],
        ),
        _buildKarmaBar(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: _buildContent(context),
    );
  }
}
