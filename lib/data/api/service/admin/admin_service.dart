import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:orario/data/api/model/api_model.dart';

class AdminService {
  Future<bool> ferifyToken(
      {@required String token, @required String path}) async {
    final db = FirebaseDatabase.instance;
    final ref = db.reference().child('uni/$path/token');

    bool isValid = false;
    await ref.once().then((value) {
      if (value.value.toString() == token) {
        isValid = true;
      }
    });
    return isValid;
  }

  Future<void> saveLessonTime(
      {@required String path, @required List<ApiLessonTime> list}) async {
    final db = FirebaseDatabase.instance;
    final ref = db.reference().child('uni/${path.split('/')[0]}/time');

    for (int lesson = 0; lesson < 7; lesson++) {
      if (list[lesson] != null) {
        await ref.child(lesson.toString()).update(list[lesson].toApi());
      }
    }
    return;
  }

  Future<void> saveLessons(
      {@required String path,
      @required int week,
      @required Map<int, Map> lessons}) async {
    final db = FirebaseDatabase.instance;
    final ref = db.reference().child('uni/$path/timetable');

    Map<int, Map> weekLesson = lessons[0] as Map<int, Map>;
    for (int day = 0; day <= 5; day++) {
      final Map<int, ApiLesson> dayLessons =
          weekLesson[day] as Map<int, ApiLesson>;
      for (int lesson = 0; lesson <= 7; lesson++) {
        if (dayLessons[lesson] != null) {
          await ref
              .child((week).toString())
              .child(day.toString())
              .child(lesson.toString())
              .set(dayLessons[lesson].toApi());
        } else {
          await ref
              .child((week).toString())
              .child(day.toString())
              .child(lesson.toString())
              .set('no');
        }
      }
    }
    weekLesson = lessons[1] as Map<int, Map>;
    for (int day = 0; day <= 5; day++) {
      final Map<int, ApiLesson> dayLessons =
          weekLesson[day] as Map<int, ApiLesson>;
      for (int lesson = 0; lesson <= 7; lesson++) {
        if (dayLessons[lesson] != null) {
          await ref
              .child((week + 2).toString())
              .child(day.toString())
              .child(lesson.toString())
              .set(dayLessons[lesson].toApi());
        } else {
          await ref
              .child((week + 2).toString())
              .child(day.toString())
              .child(lesson.toString())
              .set('no');
        }
      }
    }
  }
}
