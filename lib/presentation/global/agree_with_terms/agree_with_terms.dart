// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/settings/settings.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';

class AgreeWithTerms extends StatefulWidget {
  const AgreeWithTerms({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  /// On confirmation status changed callback.
  final Function(bool) onChanged;

  @override
  State<AgreeWithTerms> createState() => _AgreeWithTermsState();
}

class _AgreeWithTermsState extends State<AgreeWithTerms> {
  bool agree = false;

  Widget _buildCheckbox(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => agree = !agree);

        widget.onChanged(agree);
      },
      child: AnimatedCrossFade(
        firstChild: NIcon(NIcons.checkbox),
        secondChild: NIcon(NIcons.checkbox_on),
        crossFadeState: agree ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: NConstants.defaultAnimationDuration * 0.5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle style = NTypography.golosRegular14;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCheckbox(context),
        SizedBox(width: 8.w),
        Flexible(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: L10n.of(context)!.agreeWithTerms1),
                TextSpan(
                  text: L10n.of(context)!.agreeWithTerms2,
                  style: style.copyWith(decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()..onTap = () async => await launchUrl(Settings.termsOfUseUrl),
                ),
                TextSpan(text: L10n.of(context)!.agreeWithTerms3),
              ],
            ),
            style: style,
          ),
        ),
      ],
    );
  }
}
