import 'package:orario/data/api/model/api_model_export.dart';
import 'package:orario/data/api/service/lesson_time/lesson_time_service.dart';
import 'package:orario/data/mapper/lesson_time_mapper.dart';
import 'package:orario/domain/model/lesson_time.dart';
import 'package:orario/domain/repository/lesson_time_repository.dart';

class LessonTimeDataRepository extends LessonTimeRepository {
  final LessonTimeService service;

  LessonTimeDataRepository(this.service);

  @override
  Future<List<LessonTime>> getLessonTime({String path}) async {
    List<ApiLessonTime> apiList = await service.getLessonTime(path: path);

    List<LessonTime> list = [];

    apiList.forEach((apiLessonTime) {
      list.add(LessonTimeMapper.fromApi(apiLessonTime));
    });
    return list;
  }
}
