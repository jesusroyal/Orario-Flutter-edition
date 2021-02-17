import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orario/data/api/service/admin/admin_service.dart';
import 'package:orario/data/api/service/lesson_time/lesson_time_service.dart';
import 'package:orario/data/api/service/settings/settings_service.dart';
import 'package:orario/data/repository/admin/admin_data_repository.dart';
import 'package:orario/data/repository/lesson_time/lesson_time_data_repository.dart';
import 'package:orario/data/repository/settings/settings_data_repository.dart';
import 'package:orario/domain/model/model_export.dart';

import 'lesson_time_edit_event.dart';
import 'lesson_time_edit_state.dart';

class LessonTimeEditBloc
    extends Bloc<LessonTimeEditEvent, LessonTimeEditState> {
  LessonTimeEditBloc() : super(LessonTimeEditOpened());

  LessonTimeDataRepository timeRepository =
      LessonTimeDataRepository(LessonTimeService());

  SettingsDataRepository settings =
      SettingsDataRepository(settingsService: SettingsService());

  AdminDataRepository admin = AdminDataRepository(AdminService());

  Future<List<LessonTime>> getList() async {
    final String path = await settings.getPath();
    final List<LessonTime> time =
        await timeRepository.getLessonTime(path: path);
    return time;
  }

  @override
  Stream<LessonTimeEditState> mapEventToState(
      LessonTimeEditEvent event) async* {
    if (event is LessonTimeOpened) {
      yield LessonTimeEditLoading();
      final time = await getList();
      yield LessonTimeEditLoaded(time);
    }
    if (event is LessonTimePressSave) {
      yield LessonTimeEditSaving();
      final String path = await settings.getPath();
      await admin.saveLessonTime(path: path, time: event.list);
      yield LessonTimeEditSaved();
    }
  }
}
