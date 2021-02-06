import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:orario/data/api/model/api_model_export.dart';

class LessonTimeService {
  final ref = FirebaseDatabase.instance.reference().child('uni');

  Future<List<ApiLessonTime>> getLessonTime({@required String path}) async {
    final db = ref.child('${path.split('/')[0]}/time');
    final List<ApiLessonTime> list = [];
    final snapshot = await db.once();
    for (int lesson = 0; lesson < 8; lesson++) {
      if (snapshot.value[lesson] != 'no') {
        final data = snapshot.value[lesson];
        list.add(ApiLessonTime.fromApi(data as Map<String, String>));
      }
    }
    return list;
  }
}
