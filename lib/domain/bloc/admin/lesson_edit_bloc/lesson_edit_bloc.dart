import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orario/data/api/service/admin/admin_service.dart';
import 'package:orario/data/api/service/lesson/lesson_service.dart';
import 'package:orario/data/api/service/lesson_time/lesson_time_service.dart';
import 'package:orario/data/api/service/settings/settings_service.dart';
import 'package:orario/data/repository/admin/admin_data_repository.dart';
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

  Future<Map<int, Map<int, Map<int, LessonPair>>>> getPairs(int week) async {
    final String path = await settings.getPath();

    final List<LessonTime> time =
        await timeRepository.getLessonTime(path: path);
    final Map<int, Map> lessons = await lessonRepository.getLessons(path, 0);

    Map<int, Map<int, Map<int, LessonPair>>> map = {};

    for (int week = 0; week <= 1; week++) {
      Map<int, Map<int, LessonPair>> weekLessons = {};
      for (int day = 0; day <= 5; day++) {
        Map<int, LessonPair> dayLesson = {};
        for (int lesson = 0; lesson <= 7; lesson++) {
          if (lessons[week][day][lesson] != null) {
            final pair = LessonPair(
                lesson: lessons[week][day][lesson] as Lesson,
                time: time[lesson]);
            dayLesson[lesson] = pair;
          } else {
            final pair = LessonPair(lesson: null, time: time[lesson]);
            dayLesson[lesson] = pair;
          }
        }
        weekLessons[day] = dayLesson;
      }
      map[week] = weekLessons;
      weekLessons = {};
    }
    return map;
  }

  Future<void> savePairs(
      Map<int, Map<int, Map<int, LessonPair>>> lessons) async {
    final Map<int, List> saveList = {};

    Map<int, Map<int, Map<int, Lesson>>> map = {};

    for (int week = 0; week <= 1; week++) {
      Map<int, Map<int, Lesson>> weekLessons = {};
      for (int day = 0; day <= 5; day++) {
        Map<int, Lesson> dayLesson = {};
        for (int lesson = 0; lesson <= 7; lesson++) {
          if (lessons[week][day][lesson].lesson != null) {
            dayLesson[lesson] = lessons[week][day][lesson].lesson;
          } else {
            dayLesson[lesson] = null;
          }
        }
        weekLessons[day] = dayLesson;
      }
      map[week] = weekLessons;
      weekLessons = {};
    }

    admin.saveLessons(path: await settings.getPath(), lessons: map);
  }

  AdminDataRepository admin = AdminDataRepository(AdminService());

  @override
  Stream<LessonEditState> mapEventToState(LessonEditEvent event) async* {
    if (event is LessonEditOpened) {
      yield LessonEditLoading();
      final list = await getPairs(0);
      print(list);
      yield LessonEditLoaded(lessons: list);
    }
    if (event is LessonEditSave) {
      print(event.lessons);
      savePairs(event.lessons);
    }
  }
}
