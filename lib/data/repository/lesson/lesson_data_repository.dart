import 'package:orario/data/api/model/api_model.dart';
import 'package:orario/data/api/service/lesson/lesson_service.dart';
import 'package:orario/data/mapper/lesson_mapper.dart';
import 'package:orario/domain/model/model_export.dart';
import 'package:orario/domain/repository/lesson_repository.dart';

class LessonDataRepository extends LessonRepository {
  final LessonService service;

  LessonDataRepository(this.service);

  @override
  Future<Map<int, Map>> getLessons(String path, int subGroup) async {
    final Map<int, Map> apiLessons = await service.getLessons(path, subGroup);
    final Map<int, Map> lessons = {};

    for (int week = 0; week <= 1; week++) {
      var weekLessons = <int, Map>{};
      for (int day = 0; day <= 5; day++) {
        var dayLessons = <int, Lesson>{};
        for (int lesson = 0; lesson <= 8; lesson++) {
          if (apiLessons[week][day][lesson] == null) {
            dayLessons[lesson] = null;
          } else {
            dayLessons[lesson] = LessonMapper.fromApi(
                apiLessons[week][day][lesson] as ApiLesson);
          }
        }
        weekLessons[day] = dayLessons;
        dayLessons = <int, Lesson>{};
      }
      lessons[week] = weekLessons;
      weekLessons = <int, Map>{};
    }
    return lessons;
  }
}
