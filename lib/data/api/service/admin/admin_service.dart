import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:orario/data/api/model/api_model_export.dart';

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

    for (int lesson = 0; lesson < 8; lesson++) {
      if (list[lesson] != null) {
        await ref.child(lesson.toString()).update(list[lesson].toApi());
      }
    }
    return;
  }
}
