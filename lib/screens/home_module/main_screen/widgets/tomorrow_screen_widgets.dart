import 'package:flutter/material.dart';
import 'package:orario/services/orario_service.dart';
import 'package:orario/services/lesson_model.dart';

class TomorrowScreenLessonWidget extends StatelessWidget {
  final String path;
  final Lesson lesson;

  TomorrowScreenLessonWidget({this.path})
      : lesson = OrarioService.lessonDict[path];

  String get _start {
    int index = int.parse(path.split('/')[2]);
    var time = OrarioService.timeDict[index];
    if (time != null) {
      return time.startString;
    } else {
      return '${index + 1}';
    }
  }

  Color get _lessonColor {
    switch (lesson.type) {
      case LessonType.lab:
        return Colors.redAccent;
      case LessonType.lecture:
        return Colors.greenAccent;
      case LessonType.seminar:
        return Colors.blueAccent;
    }
    return Colors.white;
  }

  Widget _emptyWidget() {
    return Container(
      height: 0.0,
    );
  }

  Widget _lessonWidget() {
    return Card(
        child: Container(
            margin: EdgeInsets.all(10.0),
            width: 150.0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_start),
                  Text(
                    lesson.shortName,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Text(lesson.location),
                  Divider(
                    color: _lessonColor,
                    thickness: 1.0,
                  )
                ])));
  }

  @override
  Widget build(BuildContext context) {
    return lesson == null ? _emptyWidget() : _lessonWidget();
  }
}
