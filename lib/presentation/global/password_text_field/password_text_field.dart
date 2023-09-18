// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';

// Project imports:
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  /// On password changed callback.
  final Function(String) onChanged;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool hideText = true;

  Widget _buildHideButton(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => hideText = !hideText),
      child: NIcon(!hideText ? NIcons.eye : NIcons.eye_closed),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NTextField(
      width: double.infinity,
      keyboardType: TextInputType.visiblePassword,

      // Пароль.
      hintText: L10n.of(context)!.password,
      capitalization: TextCapitalization.none,
      onChanged: widget.onChanged,
      obscureText: hideText,
      suffix: _buildHideButton(context),
    );
  }
}
