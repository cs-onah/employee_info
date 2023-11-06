library app_date_picker;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'dart:math' as math;

part 'calendar_picker.dart';

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

class AppDatePicker extends StatelessWidget {
  const AppDatePicker({super.key});

  static Future pickDate(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime(2023),
              lastDate: DateTime(2024),
              onDateChanged: (date){},
            ),
          );
        });
    // return showDatePicker(
    //   context: context,
    //   initialDate: initialDate,
    //   firstDate: firstDate,
    //   lastDate: lastDate,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
