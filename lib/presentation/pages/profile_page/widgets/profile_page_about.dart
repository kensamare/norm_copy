// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';

class ProfilePageAbout extends StatefulWidget {
  const ProfilePageAbout({
    super.key,
    this.about,
  });

  /// User profile description.
  final String? about;

  @override
  State<ProfilePageAbout> createState() => _ProfilePageAboutState();
}

class _ProfilePageAboutState extends State<ProfilePageAbout> {
  bool unwrapped = false;

  @override
  void initState() {
    if (!widget.about.isBlank) {
      // If text length is more than 150, then it won't be unwrapped.
      unwrapped = _verifyTextLength(widget.about!);
    }

    super.initState();
  }

  @override
  void didUpdateWidget(ProfilePageAbout oldWidget) {
    if (!widget.about.isBlank) unwrapped = _verifyTextLength(widget.about!);

    super.didUpdateWidget(oldWidget);
  }

  bool _verifyTextLength(String text) => text.length <= 150;

  Widget _buildContent(BuildContext context) {
    if (widget.about.isBlank) {
      return GestureDetector(
        onTap: () => service<AppRouter>().goToEditMainInformationPage(),
        child: Text(
          L10n.of(context)!.addDescription,
          style: NTypography.golosRegular14.copyWith(color: NColors.bluePrimary),
        ),
      );
    }

    return AnimatedCrossFade(
      firstChild: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => setState(() => unwrapped = true),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${widget.about!.substring(0, widget.about!.length.clamp(0, 140))}... ',
                style: NTypography.golosRegular14,
              ),
              TextSpan(
                text: L10n.of(context)!.more,
                style: NTypography.golosRegular14.copyWith(color: NColors.bluePrimary),
              ),
            ],
          ),
        ),
      ),
      secondChild: Text(
        widget.about!,
        style: NTypography.golosRegular14,
      ),
      crossFadeState: unwrapped ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: NConstants.defaultAnimationDuration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PaddedContent(
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: _buildContent(context),
      ),
    );
  }
}
