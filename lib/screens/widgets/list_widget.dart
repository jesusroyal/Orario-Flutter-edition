import 'package:flutter/material.dart';
import 'package:orario/screens/home_module/settings_screen/edit_screen.dart';
import 'package:orario/services/lesson_model.dart';
import 'package:orario/services/orario_service.dart';

class ListWidget extends StatelessWidget {
  final String path;
  final Lesson lesson;
  final bool allowEdition;

  ListWidget({this.path, this.allowEdition})
      : lesson = OrarioService.lessonDict[path];

  Widget _emptyWidget() {
    return Container(
      height: 0.0,
    );
  }

  Widget _lessonWidget() {
    return Container(
        height: 100.0,
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Icon(Icons.cake),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    lesson.shortName,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    lesson.location,
                    textAlign: TextAlign.right,
                  )
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
      return _emptyWidget();
    } else {
      return allowEdition
          ? GestureDetector(
              child: _lessonWidget(),
              onTap: () => _edit(context),
            )
          : _lessonWidget();
    }
  }
}
