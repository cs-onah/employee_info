library app_date_picker;

import 'package:employee_list_assessment/constants/app_colors.dart';
import 'package:employee_list_assessment/utils/date_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'dart:math' as math;

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

Future<DateTime?> showAppDatePicker(
  BuildContext context, {
  PickerOption? pickerOption,
  DateTime? initialDate,
}) async {
  return await showDialog<DateTime?>(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: CalendarDatePicker(
        initialDate: initialDate,
        firstDate: DateTime(2023),
        lastDate: DateTime(2024),
        onDateChanged: (date) {},
        pickerOption: pickerOption,
      ),
    ),
  );
}
