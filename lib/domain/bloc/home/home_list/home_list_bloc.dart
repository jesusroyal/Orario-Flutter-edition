import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
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

  Future<Map<int, List<LessonPair>>> getPairs() async {
    String path = await settings.getPath();
    Map<int, List<LessonPair>> map = {};
    List<LessonTime> time = await timeRepository.getLessonTime(path: path);
    Map<int, Map> lessons = await lessonRepository.getLessons(path, 0);

    for (int week = 0; week <= 1; week++) {
      for (int day = 0; day <= 5; day++) {
        List<LessonPair> oneDay = [];
        for (int lesson = 0; lesson <= 8; lesson++) {
          if (lessons[week][day][lesson] != null) {
            var pair = LessonPair(
                lesson: lessons[week][day][lesson], time: time[lesson]);
            oneDay.add(pair);
          }
        }
        map[day] = oneDay;
        oneDay = List<LessonPair>();
      }
    }

    return map;
  }

  @override
  Stream<HomeListState> mapEventToState(HomeListEvent event) async* {
    if (event is HomeListOpened) {
      yield HomeListLoading();
      var map = await getPairs();
      yield HomeListLoaded(lessons: map, currentLesson: 2);
    }
  }
}
