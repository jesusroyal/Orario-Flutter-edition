import 'package:flutter/material.dart';

class ApiLessonTime {
  final int start;
  final int end;
  final int breakDuration;

  ApiLessonTime(
      {@required this.start, @required this.end, @required this.breakDuration});

  ApiLessonTime.fromApi(dynamic map)
      : start = int.parse(map['start']),
        end = int.parse(map['end']),
        breakDuration = int.parse(map['break']);

  Map<String, String> toApi() {
    return {'start': '$start', 'end': '$end', 'break': '$breakDuration'};
  }
}
