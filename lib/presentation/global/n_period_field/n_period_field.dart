// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field.dart';

class NPeriodField extends StatefulWidget {
  const NPeriodField({
    super.key,
    required this.onChanged,
    this.initialRange,
  });

  final Function(DateTimeRange?) onChanged;

  /// Intiial range.
  final DateTimeRange? initialRange;

  @override
  State<NPeriodField> createState() => _NPeriodFieldState();
}

class _NPeriodFieldState extends State<NPeriodField> {
  final TextEditingController _periodController = TextEditingController();

  DateTimeRange? _range;

  @override
  void initState() {
    _range = widget.initialRange;
    if (_range != null) setRangeControllerValue(_range!);

    super.initState();
  }

  void pickPeriod(BuildContext context) async {
    final DateTime now = DateTime.now();

    final DateTimeRange? range = await showDateRangePicker(
      context: context,
      initialDateRange: _range,
      firstDate: DateTime.fromMillisecondsSinceEpoch(0),
      lastDate: DateTime.fromMillisecondsSinceEpoch(now.millisecondsSinceEpoch + 86400 * 1000),
    );

    if (range != null) {
      // Call on changed range(period) callback.
      widget.onChanged(range);

      // Sets text value according to range.
      setRangeControllerValue(range);

      // Save current range.
      _range = range;
    }
  }

  void setRangeControllerValue(DateTimeRange range) {
    final DateTime start = range.start;
    final DateTime end = range.end;

    // Is range end value till current day.
    final bool isTillCurrentDay = DateTime.now().difference(end).inDays < 1;

    String generateStringValueForRange(DateTime date, DateTime secondary) {
      // If start and end years are equal.
      final bool isStartAndEndYearsEqual = date.year == secondary.year;

      if (isStartAndEndYearsEqual) {
        return '${DateFormat('MM-yyyy').format(date)} г.';
      } else {
        return '${DateFormat('yyyy').format(date)} г.';
      }
    }

    final String startString = generateStringValueForRange(start, end);
    final String endString = isTillCurrentDay ? 'по настоящее время' : generateStringValueForRange(end, start);

    _periodController.value = TextEditingValue(text: '$startString - $endString');
  }

  @override
  Widget build(BuildContext context) {
    return NTextField(
      controller: _periodController,
      width: double.infinity,
      suffix: NIcon(NIcons.calendar),
      onTap: () => pickPeriod(context),
      hintText: 'Выберите период',
    );
  }
}
