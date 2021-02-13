import 'package:flutter/material.dart';

extension WeekNumber on DateTime {
  int get weekNumber {
    final startOfYear = DateTime(this.year, 1, 1, 0, 0);
    final firstMonday = startOfYear.weekday;
    final daysInFirstWeek = 8 - firstMonday;
    final diff = this.difference(startOfYear);
    var weeks = ((diff.inDays - daysInFirstWeek) / 7).ceil();
    if (daysInFirstWeek > 3) {
      weeks += 1;
    }
    return weeks;
  }
}

extension Minutes on TimeOfDay {
  int get inMinutes {
    return hour * 60 + minute;
  }
}
