// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/reputation_dot/reputation_dot.dart';
import 'package:norm/presentation/global/user_avatar/user_avatar.dart';

class BrandPageHeader extends StatelessWidget {
  const BrandPageHeader({
    super.key,
    this.title,
    this.avatar,
    this.category,
    this.followers = 0,
    this.reputation = 1.5,
  });

  /// Brand avatar.
  final String? avatar;

  /// Title of brand.
  final String? title;

  /// Brand category.
  final String? category;

  /// Subscribers count of brand.
  final int followers;

  /// Brand reputation.
  final double reputation;

  Widget _buildKarmaIndicator(BuildContext context) {
    return ReputationDot(
      size: 32.r,
      reputation: reputation,
      child: Center(
        child: Text(
          reputation.toStringAsFixed(1),
          style: NTypography.golosMedium14.copyWith(color: NColors.white, height: 1.0),
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        UserAvatar(
          size: 96.r,
          imageUrl: avatar,
        ),
        _buildKarmaIndicator(context),
      ],
    );
  }

  Widget _buildBrandTitle(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            '$title',
            style: NTypography.golosMedium16,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildBrandField(BuildContext context) {
    return Text(
      '$category',
      style: NTypography.golosRegular14.copyWith(color: NColors.gray),
    );
  }

  Widget _buildBrandSubscribers(BuildContext context) {
    return Text(
      '$followers подписчиков',
      style: NTypography.golosRegular14.copyWith(color: NColors.gray),
    );
  }

  Widget _buildPrimaryInformation(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBrandTitle(context),
          SizedBox(height: 8.h),
          _buildBrandField(context),
          SizedBox(height: 2.h),
          _buildBrandSubscribers(context),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return PaddedContent(
      child: Column(
        children: [
          Row(
            children: [
              _buildAvatar(context),
              SizedBox(width: 16.w),
              _buildPrimaryInformation(context),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: _buildContent(context),
    );
  }
}
