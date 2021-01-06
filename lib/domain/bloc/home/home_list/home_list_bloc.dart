import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:orario/domain/model/model_export.dart';
import 'home_list_event.dart';
import 'home_list_state.dart';

class HomeListBloc extends Bloc<HomeListEvent, HomeListState> {
  HomeListBloc() : super(HomeListLoading());

  static Lesson lessons = Lesson(
      name: 'First', location: '213', don: 'Ivanov', type: LessonType.lab);
  static LessonTime time = LessonTime(
      start: TimeOfDay.now(), end: TimeOfDay.now(), breakDuration: 10);

  LessonPair pair = LessonPair(lesson: lessons, time: time);

  @override
  Stream<HomeListState> mapEventToState(HomeListEvent event) async* {
    if (event is HomeListOpened) {
      yield HomeListLoading();
      await Future.delayed(Duration(seconds: 5));
      yield HomeListLoaded(lessons: [pair], currentLesson: 2);
    }
  }
}
