// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field.dart';

class NDateField extends StatefulWidget {
  const NDateField({
    super.key,
    required this.onChanged,
    this.hint,
    this.initialDate,
  });

  final String? hint;

  /// On changed date callback.
  final Function(DateTime) onChanged;

  final DateTime? initialDate;

  @override
  State<NDateField> createState() => _NDateFieldState();
}

class _NDateFieldState extends State<NDateField> {
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    if (widget.initialDate != null) {
      setControllerValue(
        _dateController,
        DateFormat(datePattern).format(widget.initialDate!),
      );
    }

    super.initState();
  }

  void pickDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.fromMillisecondsSinceEpoch(0),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      widget.onChanged.call(date);

      setControllerValue(
        _dateController,
        DateFormat(datePattern).format(date),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return NTextField(
      controller: _dateController,
      width: double.infinity,
      hintText: widget.hint,
      suffix: NIcon(NIcons.calendar, size: 24.r),
      onTap: pickDate,
    );
  }
}
