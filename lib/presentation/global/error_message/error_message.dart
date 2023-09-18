// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/utils/infrastructure.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: Text(
        message!,
        style: NTypography.golosRegular16.copyWith(color: NColors.redError),
      ),
      secondChild: const SizedBox.shrink(),
      crossFadeState: message.isBlank ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: NConstants.defaultAnimationDuration,
    );
  }
}
