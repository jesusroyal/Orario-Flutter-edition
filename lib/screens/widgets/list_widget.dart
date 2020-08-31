import 'package:flutter/material.dart';
import 'package:orario/screens/home_module/settings_screen/edit_screen.dart';
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
    return Container(
      height: 100.0,
      color: Colors.red,
      child: Text('Пары нет'),
    );
  }

  IconData get _lessonIcon {
    switch (lesson.type) {
      case LessonType.lab:
        return Icons.computer;
      case LessonType.lecture:
        return Icons.book;
      case LessonType.seminar:
        return Icons.brush;
    }
  }

  Widget _lessonWidget() {
    return Container(
        height: 100.0,
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Icon(_lessonIcon),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(path.split('/')[2]),
                      Text(
                        lesson.shortName,
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            lesson.don,
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            lesson.location,
                            textAlign: TextAlign.right,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
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
