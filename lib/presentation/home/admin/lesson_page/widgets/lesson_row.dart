import 'package:flutter/material.dart';
import 'package:orario/domain/model/model_export.dart';
import 'package:orario/presentation/home/admin/lesson_page/widgets/lesson_tile.dart';

class LessonRow extends StatelessWidget {
  final Map<int, LessonPair> lessons;

  const LessonRow({Key key, this.lessons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(lessons[0].time.start.format(context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LessonTile(lesson: lessons[0].lesson),
            LessonTile(
              lesson: lessons[1].lesson,
            )
          ],
        ),
      ],
    );
  }
}
