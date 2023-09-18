// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';

// Project imports:
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';

class AddPhoneNumberButton extends StatelessWidget {
  const AddPhoneNumberButton({
    super.key,
    required this.onPressed,
  });

  /// On pressed callback.
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return NButton(
      onPressed: onPressed,
      title: L10n.of(context)!.addPhoneNumber,
      width: double.infinity,
      icon: NIcon(NIcons.add),
      inverted: true,
    );
  }
}
