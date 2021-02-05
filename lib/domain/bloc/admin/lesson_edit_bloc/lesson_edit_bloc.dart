import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orario/data/api/service/lesson/lesson_service.dart';
import 'package:orario/data/api/service/lesson_time/lesson_time_service.dart';
import 'package:orario/data/api/service/settings/settings_service.dart';
import 'package:orario/data/repository/lesson/lesson_data_repository.dart';
import 'package:orario/data/repository/lesson_time/lesson_time_data_repository.dart';
import 'package:orario/data/repository/settings/settings_data_repository.dart';
import 'package:orario/domain/bloc/admin/lesson_edit_bloc/lesson_edit_event.dart';
import 'package:orario/domain/bloc/admin/lesson_edit_bloc/lesson_edit_state.dart';
import 'package:orario/domain/model/model_export.dart';

class LessonEditBloc extends Bloc<LessonEditEvent, LessonEditState> {
  LessonEditBloc() : super(LessonEditLoading());

  LessonTimeDataRepository timeRepository =
      LessonTimeDataRepository(LessonTimeService());
  LessonDataRepository lessonRepository = LessonDataRepository(LessonService());
  SettingsDataRepository settings =
      SettingsDataRepository(settingsService: SettingsService());
  Future<Map<int, List<Map<int, LessonPair>>>> getPairs(int week) async {
    final String path = await settings.getPath();
    final Map<int, List<Map<int, LessonPair>>> map = {};
    final List<LessonTime> time =
        await timeRepository.getLessonTime(path: path);
    final Map<int, Map> lessons = await lessonRepository.getLessons(path, 0);

    for (int day = 0; day <= 5; day++) {
      List<Map<int, LessonPair>> oneDay = [];
      for (int lesson = 0; lesson <= 7; lesson++) {
        if (lessons[week][day][lesson] != null) {
          final pair = LessonPair(
              lesson: lessons[week][day][lesson], time: time[lesson]);
          oneDay.add({0: pair, 1: pair});
        } else {
          final pair = LessonPair(lesson: null, time: time[lesson]);
          oneDay.add({0: pair, 1: pair});
        }
      }
      map[day] = oneDay;
      oneDay = <Map<int, LessonPair>>[];
    }

    return map;
  }

  @override
  Stream<LessonEditState> mapEventToState(LessonEditEvent event) async* {
    yield LessonEditLoading();
    final list = await getPairs(0);
    yield LessonEditLoaded(lessons: list);
  }
}
