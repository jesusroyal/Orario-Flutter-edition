import 'package:flutter/material.dart';
import 'package:orario/screens/home_module/settings_screen/edit_screen.dart';
import 'package:orario/screens/ui_constants.dart';
import 'package:orario/services/lesson_model.dart';
import 'package:orario/services/orario_service.dart';

class ListWidget extends StatelessWidget {
  final String path;
  final Lesson lesson;
  final bool allowEdition;

  final VoidCallback onTap;

  ListWidget({this.path, this.allowEdition, this.onTap})
      : lesson = OrarioService.lessonDict[path];

  Widget _emptyWidget() {
    return Container(
      height: 0.0,
    );
  }

  Widget _noLesson() {
    return Card(
      color: Colors.redAccent,
      child: ListTile(
        title: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  start,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  end,
                  style: TextStyle(color: Colors.grey[300]),
                )
              ],
            ),
            SizedBox(
              width: 15.0,
            ),
            Text('Добавить пару', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
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

  String get start {
    int index = int.parse(path.split('/')[2]);
    var time = OrarioService.timeDict[index];
    if (time != null) {
      return time.startString;
    } else {
      return '${index + 1}';
    }
  }

  String get end {
    int index = int.parse(path.split('/')[2]);
    var time = OrarioService.timeDict[index];
    if (time != null) {
      return time.endString;
    } else {
      return '';
    }
  }

  Widget _lessonWidget() {
    return Card(
      margin: EdgeInsets.all(2.0),
      child: Container(
          height: 70.0,
          color: Colors.white,
          margin: EdgeInsets.all(7.0),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(start),
                  Text(
                    end,
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              VerticalDivider(
                color: _lessonColor,
                thickness: 1.0,
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lesson.shortName,
                          style: OrarioText.h2,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          lesson.don,
                          textAlign: TextAlign.right,
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Text(
                      lesson.location,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  void _edit(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditScreen(path: path),
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (lesson == null) {
      return allowEdition
          ? GestureDetector(
              child: _noLesson(),
              onTap: () => onTap(),
            )
          : _emptyWidget();
    } else {
      return allowEdition
          ? GestureDetector(
              child: _lessonWidget(),
              onTap: () => onTap(),
            )
          : _lessonWidget();
    }
  }
}
