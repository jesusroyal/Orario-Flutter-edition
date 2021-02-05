import 'package:flutter/material.dart';
import 'package:orario/domain/model/model_export.dart';
import 'package:orario/internal/theme.dart';

class LessonTile extends StatelessWidget {
  final Lesson lesson;
  final void Function() onTap;
  final void Function() onExpand;

  const LessonTile({Key key, this.lesson, this.onTap, this.onExpand})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: lesson != null ? buildLesson() : buildNull(),
      onTap: () => onTap(),
    );
  }

  Expanded buildNull() {
    return Expanded(child: Card(child: Text('no lesson')));
  }

  Expanded buildLesson() {
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
