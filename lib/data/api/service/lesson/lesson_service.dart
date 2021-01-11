import 'package:firebase_database/firebase_database.dart';
import 'package:orario/data/api/model/api_model_export.dart';

class LessonService {
  final ref = FirebaseDatabase.instance.reference().child('uni');

  Future<Map<int, Map>> getLessons(String path, int subGroup) async {
    Map<int, Map> lessons = {};
    DataSnapshot snapshot = await ref.child(path).child('timetable').once();

    for (int week = 0; week <= 1; week++) {
      var weekLessons = Map<int, Map>();
      for (int day = 0; day <= 5; day++) {
        var dayLessons = Map<int, ApiLesson>();
        for (int lesson = 0; lesson <= 8; lesson++) {
          if (snapshot.value[week][day][lesson] == 'no') {
            dayLessons[lesson] = null;
          } else {
            dayLessons[lesson] = ApiLesson.fromApi(
                snapshot.value[week][day][lesson].cast<String, dynamic>());
          }
        }
        weekLessons[day] = dayLessons;
        dayLessons = Map<int, ApiLesson>();
      }
      lessons[week] = weekLessons;
      weekLessons = Map<int, Map>();
    }

    return lessons;
  }
}
