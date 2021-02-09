import 'package:flutter/material.dart';
import 'package:orario/domain/model/model_export.dart';

abstract class AdminRepository {
  Future<bool> ferifyToken({@required String token, @required String path});
  Future<void> saveLessonTime(
      {@required List<LessonTime> time, @required String path});

  Future<void> saveLessons(
      {@required String path,
      @required int week,
      @required Map<int, Map<int, Map<int, Lesson>>> lessons});
}
