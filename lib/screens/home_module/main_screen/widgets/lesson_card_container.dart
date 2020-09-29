import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:orario/screens/home_module/main_screen/widgets/lesson_card_widget.dart';
import 'package:orario/screens/ui_constants.dart';
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
  int week = TimeService.week;
  int day = TimeService.day == 6 ? 0 : TimeService.day;

  void getCurrentLesson() {
    paths.clear();
    for (int lesson = 0; lesson < 8; lesson++) {
      if (OrarioService.lessonDict['$week/$day/$lesson'] != null) {
        paths.add(lesson);
      }
    }
  }

  int getCurrentIndex() {
    int minutes = TimeService.minutes;
    if (OrarioService.timeDict[paths.first].startInt > minutes) {
      return 0;
    }
    if (OrarioService.timeDict[paths.last].endInt < minutes) {
      return paths.length - 1;
    }

    for (int index = 0; index < paths.length; index++) {
      if (OrarioService.timeDict[paths[index]].startInt <= minutes &&
          OrarioService.timeDict[paths[index]].endInt > minutes) {
        return index;
      }
      if (OrarioService.timeDict[paths[index]].endInt <= minutes &&
          OrarioService.timeDict[paths[index]].endInt +
                  OrarioService.timeDict[paths[index]].breakDuration >
              minutes) {
        return index + 1;
      }
    }

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLesson();

    return Swiper(
      index: getCurrentIndex(),
      scrollDirection: Axis.vertical,
      loop: false,
      itemCount: paths.length,
      pagination: SwiperPagination(
          builder:
              DotSwiperPaginationBuilder(activeColor: OrarioColors.darkAccent)),
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
