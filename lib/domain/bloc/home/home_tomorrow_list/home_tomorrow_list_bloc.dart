import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orario/data/api/service/lesson/lesson_service.dart';
import 'package:orario/data/api/service/lesson_time/lesson_time_service.dart';
import 'package:orario/data/api/service/settings/settings_service.dart';
import 'package:orario/data/repository/lesson/lesson_data_repository.dart';
import 'package:orario/data/repository/lesson_time/lesson_time_data_repository.dart';
import 'package:orario/data/repository/settings/settings_data_repository.dart';
import 'package:orario/domain/bloc/home/home_tomorrow_list/home_tomorrow_list_state.dart';
import 'package:orario/domain/model/model_export.dart';
import 'package:orario/internal/extensions.dart';
import 'home_tomorrow_list_event.dart';

class HomeTomorrowListBloc
    extends Bloc<HomeTomorrowListEvent, HomeTomorrowListState> {
  HomeTomorrowListBloc() : super(HomeTomorrowListLoading());

  LessonTimeDataRepository timeRepository =
      LessonTimeDataRepository(LessonTimeService());
  LessonDataRepository lessonRepository = LessonDataRepository(LessonService());
  SettingsDataRepository settings =
      SettingsDataRepository(settingsService: SettingsService());

//TODO: Add weekend exeption
  Future<List<LessonPair>> getPairs() async {
    final DateTime now = DateTime.now();
    final String path = await settings.getPath();
    final List<LessonPair> list = [];
    final List<LessonTime> time =
        await timeRepository.getLessonTime(path: path);
    final Map<int, Map> lessons = await lessonRepository.getLessons(path, 0);
    final week = now.weekNumber.isEven ? 1 : 0;
    for (int lesson = 0; lesson <= 8; lesson++) {
      if (lessons[week][tomorrow()][lesson] != null) {
        final pair = LessonPair(
            lesson: lessons[week][tomorrow()][lesson] as Lesson,
            time: time[lesson]);
        list.add(pair);
      }
    }

    return list;
  }

  int tomorrow() {
    final DateTime now = DateTime.now();
    if (now.weekday == 7) {
      return 0;
    } else {
      return now.weekday;
    }
  }

  bool tomorrowIsWeekend() {
    final DateTime now = DateTime.now();
    return now.weekday == 6;
  }

  @override
  Stream<HomeTomorrowListState> mapEventToState(event) async* {
    yield HomeTomorrowListLoading();
    if (tomorrowIsWeekend()) {
      yield HomeTomorrowListNoLessons();
    } else {
      final list = await getPairs();
      yield HomeTomorrowListLoaded(lessons: list);
    }
  }
}
