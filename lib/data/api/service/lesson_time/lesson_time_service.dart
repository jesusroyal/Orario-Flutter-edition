import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:orario/data/api/model/api_model_export.dart';

class LessonTimeService {
  final ref = FirebaseDatabase.instance.reference().child('uni');

  Future<List<ApiLessonTime>> getLessonTime({@required String path}) async {
    var db = ref.child('${path.split('/')[0]}/time');
    print('$path');
    List<ApiLessonTime> list = [];
    var snapshot = await db.once();
    print('$snapshot');
    print('${snapshot.value}');
    for (int lesson = 0; lesson < 8; lesson++) {
      if (snapshot.value[lesson] != 'no') {
        var data = snapshot.value[lesson];
        print(data);
        list.add(ApiLessonTime.fromApi(data));
      }
    }
    return list;
  }
}
