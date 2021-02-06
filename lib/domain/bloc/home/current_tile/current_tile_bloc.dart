import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orario/data/api/service/lesson/lesson_service.dart';
import 'package:orario/data/api/service/lesson_time/lesson_time_service.dart';
import 'package:orario/data/api/service/settings/settings_service.dart';
import 'package:orario/data/repository/lesson/lesson_data_repository.dart';
import 'package:orario/data/repository/lesson_time/lesson_time_data_repository.dart';
import 'package:orario/data/repository/settings/settings_data_repository.dart';
import 'package:orario/domain/bloc/home/current_tile/current_tile_event.dart';
import 'package:orario/domain/bloc/home/current_tile/current_tile_state.dart';
import 'package:orario/domain/model/model_export.dart';

class CurrentTileBloc extends Bloc<CurrentTileEvent, CurrentTileState> {
  CurrentTileBloc() : super(CurrentTileLoading());

  LessonTimeDataRepository timeRepository =
      LessonTimeDataRepository(LessonTimeService());
  LessonDataRepository lessonRepository = LessonDataRepository(LessonService());
  SettingsDataRepository settings =
      SettingsDataRepository(settingsService: SettingsService());

  //TODO: Refactor
  int weekNumber(DateTime date) {
    final startOfYear = DateTime(date.year, 1, 1);
    final firstMonday = startOfYear.weekday;
    final daysInFirstWeek = 8 - firstMonday;
    final diff = date.difference(startOfYear);
    var weeks = ((diff.inDays - daysInFirstWeek) / 7).ceil();
    if (daysInFirstWeek > 3) {
      weeks += 1;
    }
    return weeks;
  }

  Future<List<LessonPair>> getPairs() async {
    final DateTime now = DateTime.now();

    final String path = await settings.getPath();
    final List<LessonPair> list = [];
    final List<LessonTime> time =
        await timeRepository.getLessonTime(path: path);
    final Map<int, Map> lessons = await lessonRepository.getLessons(path, 0);
    final week = weekNumber(now).isEven ? 1 : 0;
    for (int lesson = 0; lesson <= 8; lesson++) {
      if (lessons[week][now.weekday - 1][lesson] != null) {
        final pair = LessonPair(
            lesson: lessons[week][now.weekday - 1][lesson] as Lesson,
            time: time[lesson]);
        list.add(pair);
      }
    }

    return list;
  }

  bool isWeekend() {
    final DateTime now = DateTime.now();
    return now.weekday == 7;
  }

  @override
  Stream<CurrentTileState> mapEventToState(CurrentTileEvent event) async* {
    yield CurrentTileLoading();
    if (isWeekend()) {
      yield CurrentTileNoLessons();
    } else {
      final pairs = await getPairs();
      yield CurrentTileLoaded(lessons: pairs, currentLesson: 0);
    }
  }
}
