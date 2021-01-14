import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orario/data/api/service/lesson/lesson_service.dart';
import 'package:orario/data/api/service/lesson_time/lesson_time_service.dart';
import 'package:orario/data/api/service/settings/settings_service.dart';
import 'package:orario/data/repository/lesson/lesson_data_repository.dart';
import 'package:orario/data/repository/lesson_time/lesson_time_data_repository.dart';
import 'package:orario/data/repository/settings/settings_data_repository.dart';
import 'package:orario/domain/bloc/home/home_list/home_list_event.dart';
import 'package:orario/domain/bloc/home/home_list/home_list_state.dart';
import 'package:orario/domain/bloc/home/home_tomorrow_list/home_tomorrow_list_state.dart';
import 'package:orario/domain/model/model_export.dart';

import 'home_tomorrow_list_event.dart';

class HomeTomorrowListBloc
    extends Bloc<HomeTomorrowListEvent, HomeTomorrowListState> {
  HomeTomorrowListBloc() : super(HomeTomorrowListLoading());

  LessonTimeDataRepository timeRepository =
      LessonTimeDataRepository(LessonTimeService());
  LessonDataRepository lessonRepository = LessonDataRepository(LessonService());
  SettingsDataRepository settings =
      SettingsDataRepository(settingsService: SettingsService());

  Future<List<LessonPair>> getPairs() async {
    String path = await settings.getPath();
    List<LessonPair> list = [];
    List<LessonTime> time = await timeRepository.getLessonTime(path: path);
    Map<int, Map> lessons = await lessonRepository.getLessons(path, 0);

    for (int lesson = 0; lesson <= 8; lesson++) {
      if (lessons[0][0][lesson] != null) {
        var pair =
            LessonPair(lesson: lessons[0][0][lesson], time: time[lesson]);
        list.add(pair);
      }
    }

    return list;
  }

  @override
  Stream<HomeTomorrowListState> mapEventToState(event) async* {
    yield HomeTomorrowListLoading();
    var list = await getPairs();
    yield HomeTomorrowListLoaded(lessons: list);
  }
}
