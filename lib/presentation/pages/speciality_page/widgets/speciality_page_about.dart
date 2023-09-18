// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';

class SpecialityPageAbout extends StatefulWidget {
  const SpecialityPageAbout({
    super.key,
    this.about,
    this.onTapAddDescription,
  });

  /// Brand profile description.
  final String? about;

  /// On tap add description callback.
  final Function()? onTapAddDescription;

  @override
  State<SpecialityPageAbout> createState() => _SpecialityPageAboutState();
}

class _SpecialityPageAboutState extends State<SpecialityPageAbout> {
  bool unwrapped = false;

  @override
  void initState() {
    if (!widget.about.isBlank) {
      // If text length is more than 150, then it won't be unwrapped.
      unwrapped = widget.about!.length <= 150;
    }

    super.initState();
  }

  Widget _buildContent(BuildContext context) {
    if (widget.about.isBlank) {
      return GestureDetector(
        onTap: widget.onTapAddDescription,
        child: Text(
          'Добавить описание',
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
