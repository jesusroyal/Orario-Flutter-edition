import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class LessonTime {
  final TimeOfDay start;
  final TimeOfDay end;
  final int breakDuration;

  LessonTime({
    @required this.start,
    @required this.end,
    @required this.breakDuration,
  });
}