import 'package:flutter/material.dart';
import 'package:orario/domain/model/model_export.dart';
import 'package:orario/internal/theme.dart';

class LessonTile extends StatelessWidget {
  final Lesson lesson;

  const LessonTile({Key key, this.lesson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              lesson.name,
              style: OrarioUI.text.h4,
              textAlign: TextAlign.left,
            ),
            Text(
              lesson.don,
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            Text(
              lesson.location,
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
