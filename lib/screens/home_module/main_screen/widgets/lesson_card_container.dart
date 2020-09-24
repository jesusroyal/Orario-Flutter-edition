import 'package:flutter/material.dart';
import 'package:orario/screens/home_module/main_screen/widgets/lesson_card_widget.dart';
import 'package:orario/services/orario_service.dart';
import 'package:orario/services/time_model.dart';
import 'package:orario/services/time_service.dart';

class LessonCardContainer extends StatefulWidget {
  LessonCardContainer({Key key}) : super(key: key);

  @override
  _LessonCardContainerState createState() => _LessonCardContainerState();
}

class _LessonCardContainerState extends State<LessonCardContainer> {
  int getCurrentLesson() {
    int minutes = TimeService.minutes;
    int week = TimeService.week;
    int day = TimeService.day;

    for (int i = 0; i < 8; i++) {
      TimeMoment time = OrarioService.timeDict[i];
      if (minutes > time.startInt &&
          minutes < time.endInt &&
          OrarioService.lessonDict['$week/$day/$i'] != null) {
        return i;
      }
      if (minutes > time.endInt &&
          minutes < time.endInt + time.breakDuration &&
          OrarioService.lessonDict['$week/$day/${i + 1}'] != null) {
        return i + 1;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    int index = getCurrentLesson();
    int week = TimeService.week;
    int day = TimeService.day;
    return LessonCard(
      lesson: OrarioService.lessonDict['$week/$day/$index'],
      time: OrarioService.timeDict[index],
    );
  }
}
