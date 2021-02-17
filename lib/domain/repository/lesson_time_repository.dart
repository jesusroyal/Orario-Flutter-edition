import 'package:flutter/material.dart';
import 'package:orario/domain/model/model_export.dart';

abstract class LessonTimeRepository {
  Future<List<LessonTime>> getLessonTime({@required String path});
}
