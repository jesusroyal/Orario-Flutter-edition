import 'package:orario/data/api/model/api_model_export.dart';
import 'package:orario/data/api/service/admin/admin_service.dart';
import 'package:orario/data/mapper/lesson_time_mapper.dart';
import 'package:orario/domain/model/lesson_time.dart';
import 'package:orario/domain/repository/admin_repostory.dart';

class AdminDataRepository extends AdminRepository {
  final AdminService service;

  AdminDataRepository(this.service);

  @override
  Future<bool> ferifyToken({String token, path}) {
    return service.ferifyToken(token: token, path: path);
  }

  Future<void> saveLessonTime({List<LessonTime> time, String path}) async {
    List<ApiLessonTime> list = []; //TODO: VERY IMPORTANT add null coalising
    time.forEach((element) {
      list.add(LessonTimeMapper.toApi(element));
    });
    await service.saveLessonTime(path: path, list: list);
    return;
  }
}
