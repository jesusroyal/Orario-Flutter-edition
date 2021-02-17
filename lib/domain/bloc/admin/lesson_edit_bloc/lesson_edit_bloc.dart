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

  Future<Map<int, Map<int, Map<int, LessonPair>>>> getPairs({int week}) async {
    final String path = await settings.getPath();

    final List<LessonTime> time =
        await timeRepository.getLessonTime(path: path);
    final Map<int, Map> lessons = await lessonRepository.getLessons(path, 0);
    final Map<int, Map> lessonsS = await lessonRepository.getLessons(path, 1);

    final Map<int, Map<int, Map<int, LessonPair>>> map = {};

    for (int sg = 0; sg <= 1; sg++) {
      Map<int, Map<int, LessonPair>> weekLessons = {};
      for (int day = 0; day <= 5; day++) {
        final Map<int, LessonPair> dayLesson = {};
        for (int lesson = 0; lesson <= 7; lesson++) {
          if (sg == 0) {
            if (lessons[week][day][lesson] != null) {
              final pair = LessonPair(
                  lesson: lessons[week][day][lesson] as Lesson,
                  time: time[lesson]);
              dayLesson[lesson] = pair;
            } else {
              final pair = LessonPair(lesson: null, time: time[lesson]);
              dayLesson[lesson] = pair;
            }
          } else {
            if (lessonsS[week][day][lesson] != null) {
              final pair = LessonPair(
                  lesson: lessonsS[week][day][lesson] as Lesson,
                  time: time[lesson]);
              dayLesson[lesson] = pair;
            } else {
              final pair = LessonPair(lesson: null, time: time[lesson]);
              dayLesson[lesson] = pair;
            }
          }
        }
        weekLessons[day] = dayLesson;
      }
      map[sg] = weekLessons;
      weekLessons = {};
    }
    return map;
  }

  Future<void> savePairs(
      int week, Map<int, Map<int, Map<int, LessonPair>>> lessons) async {
    final Map<int, Map<int, Map<int, Lesson>>> map = {};

    for (int week = 0; week <= 1; week++) {
      Map<int, Map<int, Lesson>> weekLessons = {};
      for (int day = 0; day <= 5; day++) {
        final Map<int, Lesson> dayLesson = {};
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

    admin.saveLessons(path: await settings.getPath(), week: week, lessons: map);
  }

  AdminDataRepository admin = AdminDataRepository(AdminService());

  @override
  Stream<LessonEditState> mapEventToState(LessonEditEvent event) async* {
    if (event is LessonEditOpened) {
      yield LessonEditLoading();
      final list = await getPairs(week: 0);
      yield LessonEditLoaded(lessons: list, week: 0);
    }
    if (event is LessonEditChangedWeek) {
      final int week = event.week;
      yield LessonEditLoading();
      final list = await getPairs(week: week);
      yield LessonEditLoaded(lessons: list, week: week);
    }

    if (event is LessonEditCopyWeek) {
      savePairs(0, event.lessons);
      yield LessonEditLoaded(lessons: event.lessons, week: 1);
    }

    if (event is LessonEditSave) {
      savePairs(event.week, event.lessons);
    }
  }
}
