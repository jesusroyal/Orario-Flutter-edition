import 'package:firebase_database/firebase_database.dart';
import 'package:orario/data/api/model/api_model_export.dart';

class LessonService {
  final ref = FirebaseDatabase.instance.reference().child('uni');

  Future<Map<int, Map>> getLessons(String path, int subGroup) async {
    final Map<int, Map> lessons = {};
    final DataSnapshot snapshot =
        await ref.child(path).child('timetable').once();

    for (int week = 0; week <= 1; week++) {
      var weekLessons = <int, Map>{};
      for (int day = 0; day <= 5; day++) {
        var dayLessons = <int, ApiLesson>{};
        for (int lesson = 0; lesson <= 8; lesson++) {
          if (snapshot.value[week][day][lesson] == 'no') {
            dayLessons[lesson] = null;
          } else {
            dayLessons[lesson] = ApiLesson.fromApi(Map<String, dynamic>.from(
                snapshot.value[week][day][lesson] as Map<dynamic, dynamic>));
          }
        }
        weekLessons[day] = dayLessons;
        dayLessons = <int, ApiLesson>{};
      }
      lessons[week] = weekLessons;
      weekLessons = <int, Map>{};
    }

    return lessons;
  }
}
