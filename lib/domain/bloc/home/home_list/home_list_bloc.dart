import 'package:bloc/bloc.dart';
import 'package:orario/data/api/service/lesson/lesson_service.dart';
import 'package:orario/data/api/service/lesson_time/lesson_time_service.dart';
import 'package:orario/data/api/service/settings/settings_service.dart';
import 'package:orario/data/repository/lesson/lesson_data_repository.dart';
import 'package:orario/data/repository/lesson_time/lesson_time_data_repository.dart';
import 'package:orario/data/repository/settings/settings_data_repository.dart';
import 'package:orario/domain/model/model_export.dart';
import 'home_list_event.dart';
import 'home_list_state.dart';

class HomeListBloc extends Bloc<HomeListEvent, HomeListState> {
  HomeListBloc() : super(HomeListLoading());
  LessonTimeDataRepository timeRepository =
      LessonTimeDataRepository(LessonTimeService());
  LessonDataRepository lessonRepository = LessonDataRepository(LessonService());
  SettingsDataRepository settings =
      SettingsDataRepository(settingsService: SettingsService());

  Future<Map<int, List<LessonPair>>> getPairs(int week) async {
    final String path = await settings.getPath();
    final Map<int, List<LessonPair>> map = {};
    final List<LessonTime> time =
        await timeRepository.getLessonTime(path: path);
    final Map<int, Map> lessons = await lessonRepository.getLessons(path, 0);

    for (int day = 0; day <= 5; day++) {
      List<LessonPair> oneDay = [];
      for (int lesson = 0; lesson <= 8; lesson++) {
        if (lessons[week][day][lesson] != null) {
          final pair = LessonPair(
              lesson: lessons[week][day][lesson], time: time[lesson]);
          oneDay.add(pair);
        }
      }
      map[day] = oneDay;
      oneDay = <LessonPair>[];
    }

    return map;
  }

  @override
  Stream<HomeListState> mapEventToState(HomeListEvent event) async* {
    if (event is HomeListOpened) {
      yield HomeListLoading();
      final map = await getPairs(0);
      yield HomeListLoaded(isSecondWeek: false, lessons: map, currentLesson: 2);
    }
    if (event is HomeListDidChooseWeek) {
      yield HomeListLoading();
      if (event.isSecondWeek) {
        final map = await getPairs(1);
        yield HomeListLoaded(
            isSecondWeek: true, lessons: map, currentLesson: 2);
      } else {
        final map = await getPairs(0);
        yield HomeListLoaded(
            isSecondWeek: false, lessons: map, currentLesson: 2);
      }
    }
  }
}
