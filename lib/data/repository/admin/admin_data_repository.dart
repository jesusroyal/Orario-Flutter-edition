import 'package:orario/data/api/model/api_model_export.dart';
import 'package:orario/data/api/service/admin/admin_service.dart';
import 'package:orario/data/mapper/lesson_mapper.dart';
import 'package:orario/data/mapper/lesson_time_mapper.dart';
import 'package:orario/domain/model/lesson_time.dart';
import 'package:orario/domain/model/model_export.dart';
import 'package:orario/domain/repository/admin_repostory.dart';

class AdminDataRepository extends AdminRepository {
  final AdminService service;

  AdminDataRepository(this.service);

  @override
  Future<bool> ferifyToken({String token, String path}) {
    return service.ferifyToken(token: token, path: path);
  }

  @override
  Future<void> saveLessonTime({List<LessonTime> time, String path}) async {
    final List<ApiLessonTime> list =
        []; //TODO: VERY IMPORTANT add null coalising
    time.forEach((element) {
      list.add(LessonTimeMapper.toApi(element));
    });
    await service.saveLessonTime(path: path, list: list);
    return;
  }

  @override
  Future<void> saveLessons(
      {String path, Map<int, Map<int, Map<int, Lesson>>> lessons}) {
    final Map<int, Map> apiLessons = {};
    for (int week = 0; week <= 1; week++) {
      var weekLessons = <int, Map>{};
      for (int day = 0; day <= 5; day++) {
        var dayLessons = <int, ApiLesson>{};
        for (int lesson = 0; lesson <= 7; lesson++) {
          if (lessons[week][day][lesson] == null) {
            dayLessons[lesson] = null;
          } else {
            dayLessons[lesson] =
                LessonMapper.toApi(lessons[week][day][lesson] as Lesson);
          }
        }
        weekLessons[day] = dayLessons;
        dayLessons = <int, ApiLesson>{};
      }
      apiLessons[week] = weekLessons;
      weekLessons = <int, Map>{};
    }
    return service.saveLessons(path: path, lessons: apiLessons);
  }
}
