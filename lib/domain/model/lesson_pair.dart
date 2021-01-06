import 'package:flutter/material.dart';

import './lesson.dart';
import './lesson_time.dart';

class LessonPair {
  final Lesson lesson;
  final LessonTime time;
  LessonPair({@required this.lesson, @required this.time});
}
