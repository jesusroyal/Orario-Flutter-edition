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
      onTap: () => onTap(),
      child: lesson != null ? buildLesson() : buildNull(),
    );
  }

  Widget buildNull() {
    return Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.add_circle),
        SizedBox(
          height: 50.0,
          width: 0.0,
        ),
        Text('Добавить')
      ],
    ));
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
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
            Text(
              lesson.location,
              textAlign: TextAlign.left,
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
