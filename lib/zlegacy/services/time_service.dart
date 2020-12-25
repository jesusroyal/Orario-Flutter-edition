import 'package:flutter/material.dart';

class TimeService {
  static int get week {
    int week;
    String date = DateTime.now().toString();

    String firstDay = date.substring(0, 7) + '01' + date.substring(10);
    int weekDay = DateTime.parse(firstDay).weekday;
    int currentWeek;
    if (weekDay == 7) {
      currentWeek = (DateTime.now().day / 7).ceil();
    } else {
      currentWeek = ((DateTime.now().day + weekDay) / 7).ceil();
    }
    week = currentWeek.isEven ? 1 : 0;
    return week;
  }

  static int get minutes {
    TimeOfDay now = TimeOfDay.now();
    return now.hour * 60 + now.minute;
  }

  static int get day {
    return DateTime.now().weekday - 1;
  }
}
