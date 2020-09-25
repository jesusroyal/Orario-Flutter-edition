import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:orario/screens/home_module/main_screen/widgets/lesson_card_widget.dart';
import 'package:orario/services/lesson_model.dart';
import 'package:orario/services/orario_service.dart';
import 'package:orario/services/time_model.dart';
import 'package:orario/services/time_service.dart';

class LessonCardContainer extends StatefulWidget {
  LessonCardContainer({Key key}) : super(key: key);

  @override
  _LessonCardContainerState createState() => _LessonCardContainerState();
}

class _LessonCardContainerState extends State<LessonCardContainer> {
  static List<int> paths = [];

  int getCurrentLesson() {
    int week = TimeService.week;
    int day = TimeService.day;

    for (int lesson = 0; lesson < 8; lesson++) {
      if (OrarioService.lessonDict['$week/$day/$lesson'] != null) {
        paths.add(lesson);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int index = getCurrentLesson();
    int week = TimeService.week;
    int day = TimeService.day;
    return Swiper(
      scrollDirection: Axis.vertical,
      loop: false,
      itemCount: paths.length,
      pagination: SwiperPagination(),
      control: null,
      itemBuilder: (BuildContext context, int index) {
        return LessonCard(
          lesson: OrarioService.lessonDict['$week/$day/${paths[index]}'],
          time: OrarioService.timeDict[paths[index]],
        );
      },
    );
  }
}
