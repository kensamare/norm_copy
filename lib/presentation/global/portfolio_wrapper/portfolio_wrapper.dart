// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/portfolio/portfolio.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/reputation_dot/reputation_dot.dart';

class PortfolioWrapper extends StatelessWidget {
  const PortfolioWrapper({
    super.key,
    required this.portfolio,
  });

  final Portfolio portfolio;

  Widget _buildImage(BuildContext context) {
    if (portfolio.photos.isEmpty) {
      return const SizedBox.shrink();
    }

    return CachedNetworkImage(
      imageUrl: portfolio.photos.first,
      fit: BoxFit.cover,
    );
  }

  Widget _buildData(BuildContext context) {
    return PaddedContent(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Text(
                portfolio.title,
                style: NTypography.golosRegular14.copyWith(color: NColors.white),
              ),
              SizedBox(width: 6.w),
              ReputationDot(
                size: 8.r,
                reputation: portfolio.reputation,
              ),
            ],
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _buildGradient(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            NColors.black.withOpacity(0),
            NColors.black.withOpacity(0.55),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildImage(context),
          _buildGradient(context),
          _buildData(context),
        ],
      ),
    );
  }
}
