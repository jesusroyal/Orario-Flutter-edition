import 'package:flutter/material.dart';

class TimeMoment {
  TimeOfDay start;
  TimeOfDay end;

  int breakDuration = 0;

  String get startString {
    return '${start.hour}:${start.minute}';
  }

  String get endString {
    return '${end.hour}:${end.minute}';
  }

  int get startInt {
    return (start.hour * 60) + start.minute;
  }

  int get endInt {
    return (end.hour * 60) + end.minute;
  }

  Map<String, String> get FBDict {
    return {
      'start': '${(start.hour * 60) + start.minute}',
      'end': '${(end.hour * 60) + end.minute}',
      'break': '$breakDuration'
    };
  }

  TimeMoment({this.start, this.end});

  TimeMoment.fromDynamicMap(dynamic map) {
    int startInt = int.parse(map["start"]);
    int endInt = int.parse(map["end"]);

    start = TimeOfDay(
        hour: (startInt ~/ 60), minute: (startInt - (startInt ~/ 60) * 60));
    end =
        TimeOfDay(hour: (endInt ~/ 60), minute: (endInt - (endInt ~/ 60) * 60));
    breakDuration = int.parse(map["break"]);
  }
}
