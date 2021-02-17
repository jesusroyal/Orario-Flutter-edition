import 'package:flutter/material.dart';
import 'package:orario/domain/model/model_export.dart';
import 'package:orario/presentation/home/admin/lesson_page/widgets/lesson_tile.dart';

class LessonRow extends StatelessWidget {
  final Map<int, LessonPair> lessons;
  final Function(int) onTap;
  final Function onExpand;

  const LessonRow({Key key, this.lessons, this.onTap, this.onExpand})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(lessons[0].time.start.format(context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child:
                  Stack(alignment: AlignmentDirectional.centerEnd, children: [
                LessonTile(
                  lesson: lessons[0].lesson,
                  onTap: () {
                    onTap(0);
                  },
                ),
                Container(
                    height: 35.0,
                    width: 35.0,
                    child: FittedBox(
                      child: FloatingActionButton(
                        onPressed: () {},
                        elevation: 2.0,
                        child: const Icon(Icons.arrow_forward),
                      ),
                    ))
              ]),
            ),
            Expanded(
              child: LessonTile(
                  lesson: lessons[1].lesson,
                  onTap: () {
                    onTap(1);
                  }),
            )
          ],
        ),
      ],
    );
  }
}
