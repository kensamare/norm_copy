// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/user/user.dart';

class NColors {
  // Base colors.
  static const Color transparent = Color(0x00000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF1E1E1C);

  static const Color background = Color(0xFFE0DED8);

  // Bottom app bar.
  static const Color inactiveBottomAppBarColor = black;
  static const Color activeBottomAppBarColor = bluePrimary;

  // Gray colors.
  static const Color gray = Color(0xFFAEA8A8);
  static const Color gray2 = Color(0xFFF2F2F2);
  static const Color gray3 = Color(0xFFF8F8F8);
  static const Color gray4 = Color(0xFFFBFBFB);
  static const Color graySecondaryText = Color(0xFF73726F);

  // Purple colors.
  static const Color purplePrimary = Color(0xFFB85DFF);

  // Red colors.
  static const Color redPrimary = Color(0xFFFF2D55);
  static const Color redError = redPrimary;

  // Blue colors.
  static const Color bluePrimary = Color(0xFF007AFF);

  // Green colors.
  static const Color greenPrimary = Color(0xFF34C759);

  // Reputation colors.
  static const Color reputationRed = Color(0xFFFF2D05);
  static const Color reputationOrange = Color(0xFFFF9500);
  static const Color reputationYellow = Color(0xFFFFCC00);
  static const Color reputationGreen = Color(0xFF34C759);

  static const Map<Reputation, Color> colorOfReputation = {
    Reputation.low: reputationRed,
    Reputation.medium: reputationOrange,
    Reputation.high: reputationYellow,
    Reputation.veryHigh: reputationGreen,
  };

  // Grade Gradient colors.
  static const Color startGradeRedGradient = Color(0xFFFF003D);
  static const Color endGradeRedGradient = Color(0xFFFBAD38);
  static const Color startGradeGreenGradient = Color(0xFF16984D);
  static const Color endGradeGreenGradient = Color(0xFF04C522);
}

class NTypography {
  static const TextStyle _golosFontStyle = TextStyle(fontFamily: 'Golos', color: NColors.black);
  static const TextStyle _rfDewiFontStyle = TextStyle(fontFamily: 'RFDewi', color: NColors.black);

  // Golos typography.

  // Regular.
  static final TextStyle golosRegular12 =
      _golosFontStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 12.w, height: 14 / 12);
  static final TextStyle golosRegular14 =
      _golosFontStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 14.w, height: 20 / 14);
  static final TextStyle golosRegular16 =
      _golosFontStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 16.w, height: 24 / 16);

  // Medium.
  static final TextStyle golosMedium12 =
      _golosFontStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 12.w, height: 12 / 12);
  static final TextStyle golosMedium14 =
      _golosFontStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.w, height: 24 / 14);
  static final TextStyle golosMedium16 =
      _golosFontStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 16.w, height: 24 / 16);

  //
  //
  //

  // RF Dewi typography.

  // Regular.
  static final TextStyle rfDewiRegular14 =
      _rfDewiFontStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 14.w, height: 20 / 14);

  // Semibold.
  static final TextStyle rfDewiSemibold32 =
      _rfDewiFontStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 32.w, height: 40 / 32);

  // Bold.
  static final TextStyle rfDewiBold20 =
      _rfDewiFontStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 20.w, height: 32 / 20);
  static final TextStyle rfDewiBold24 =
      _rfDewiFontStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 24.w, height: 32 / 24);
}

class NConstants {
  /// One second duration.
  static const Duration aSecond = Duration(seconds: 1);

  /// Default animation duration. 300 ms.
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);

  /// Side padding.
  static const double sidePadding = 16;
}
