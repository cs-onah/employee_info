library app_date_picker;

import 'package:employee_list_assessment/constants/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'dart:math' as math;

import 'package:intl/intl.dart' as intl;

part 'calendar_picker.dart';
part 'calendar_picker_options.dart';

// Sun - Sat
const List<String> shortWeekdays = <String>[
  'Sun',
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
];

const firstDayOfWeekIndex = 0;

final dateDisplayFormat = intl.DateFormat.yMMMd();

class AppDatePicker extends StatelessWidget {
  const AppDatePicker({super.key});

  static Future<DateTime?> pickDate(BuildContext context, {PickerOption? pickerOption}) async {
    return await showDialog<DateTime?>(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: CalendarDatePicker(
          initialDate: DateTime.now(),
          firstDate: DateTime(2023),
          lastDate: DateTime(2024),
          onDateChanged: (date) {},
          pickerOption: pickerOption,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
