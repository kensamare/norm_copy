// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';

class ConfirmAction extends StatelessWidget {
  const ConfirmAction({
    super.key,
    required this.title,
    this.onTap,
    this.alert = false,
    this.inverted = false,
  });

  /// On tap action callback.
  final Function()? onTap;

  /// Action title.
  final String title;

  /// If action is inverted or not.
  final bool inverted;

  /// If action is alert or not.
  final bool alert;

  @override
  Widget build(BuildContext context) {
    return NButton(
      onPressed: onTap ?? AutoRouter.of(context).pop,
      width: double.infinity,
      title: title,
      inverted: inverted,
      colour: alert ? NColors.redError : null,
    );
  }
}
