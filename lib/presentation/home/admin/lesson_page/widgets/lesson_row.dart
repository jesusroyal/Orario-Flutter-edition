import 'package:flutter/material.dart';
import 'package:orario/domain/model/model_export.dart';
import 'package:orario/presentation/home/admin/lesson_page/widgets/lesson_tile.dart';

class LessonRow extends StatelessWidget {
  final Map<int, LessonPair> lessons;
  final Function(int) onTap;

  const LessonRow({Key key, this.lessons, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(lessons[0].time.start.format(context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LessonTile(
              lesson: lessons[0].lesson,
              onTap: () {
                onTap(0);
              },
            ),
            LessonTile(
                lesson: lessons[1].lesson,
                onTap: () {
                  onTap(1);
                })
          ],
        ),
      ],
    );
  }
}
