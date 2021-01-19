import 'package:flutter/material.dart';
import 'package:orario/domain/model/model_export.dart';

abstract class AdminRepository {
  Future<bool> ferifyToken({@required String token, @required path});
  Future<void> saveLessonTime(
      {@required List<LessonTime> time, @required String path});
}
