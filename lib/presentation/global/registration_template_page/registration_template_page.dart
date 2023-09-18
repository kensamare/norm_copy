// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/back_button/n_back_button.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';

class RegistrationTemplatePage extends StatelessWidget {
  const RegistrationTemplatePage({
    super.key,
    this.header,
    this.subtitle,
    this.customSubtitle,
    this.content,
    this.includeSpacer = true,
    this.errors,
    this.padContent = true,
    this.onSkip,
    this.resizeToAvoidBottomInset = true,
  });

  /// Content of page.
  final Widget? content;

  /// Custom subtitle of the page.
  final Widget? customSubtitle;

  /// Header text.
  final String? header;

  /// Subtitle text. Could be null if provided custom.
  final String? subtitle;

  /// Error codes.
  final Widget? errors;

  /// Include spacer or not.
  final bool includeSpacer;

  /// Apply padding on content.
  final bool padContent;

  final bool resizeToAvoidBottomInset;

  /// On Skip button callback.
  final Function()? onSkip;

  AppRouter get router => service<AppRouter>();

  Widget _buildSubtitle(BuildContext context) {
    return SizedBox(
      width: 280.w,
      child: Text(
        subtitle!,
        style: NTypography.golosRegular16.copyWith(color: NColors.graySecondaryText),
      ),
    );
  }

  Widget _buildSkipButton(BuildContext context) {
    return PaddedContent(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onSkip,
        child: Text(
          L10n.of(context)!.skip,
          style: NTypography.golosRegular14,
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 18.h),
        SizedBox(
          height: 24.h,
          child: router.canPop()
              ? NBackButton(
                  color: NColors.black.withOpacity(0.4),
                )
              : const SizedBox.shrink(),
        ),
        SizedBox(height: 24.h),
        if (header != null) ...[
          SizedBox(
            width: 302.w,
            child: Text(header!, style: NTypography.rfDewiSemibold32),
          ),
          SizedBox(height: 20.h),
        ],
        if (subtitle != null || customSubtitle != null) ...[
          if (customSubtitle == null) _buildSubtitle(context),
          if (customSubtitle != null) customSubtitle!,
          SizedBox(height: 20.h),
        ],
        if (errors != null) errors!,
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
            child: _buildHeader(context),
          ),
          if (includeSpacer) const Spacer(),
          if (content != null) content!,
          SizedBox(height: 16.h),
          if (onSkip != null) ...[
            _buildSkipButton(context),
            SizedBox(height: 24.h),
          ]
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: NColors.background,
      body: _buildContent(context),
    );
  }
}
