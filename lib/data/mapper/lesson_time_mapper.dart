import 'package:flutter/material.dart';
import 'package:orario/domain/model/model_export.dart';
import 'package:orario/data/api/model/api_model_export.dart';

class LessonTimeMapper {
  static LessonTime fromApi(ApiLessonTime apiLessonTime){
    TimeOfDay start = TimeOfDay(
        hour: (apiLessonTime.start ~/ 60), minute: (apiLessonTime.start - (apiLessonTime.start ~/ 60) * 60));
    TimeOfDay end =
        TimeOfDay(hour: (apiLessonTime.end ~/ 60), minute: (apiLessonTime.end - (apiLessonTime.end ~/ 60) * 60));

        return LessonTime(start: start, end: end, breakDuration: apiLessonTime.breakDuration);
  }
}

