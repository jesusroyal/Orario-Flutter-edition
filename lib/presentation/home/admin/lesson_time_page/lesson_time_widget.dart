import 'package:flutter/material.dart';
import 'package:orario/domain/model/model_export.dart';

class LessonTimeTile extends StatelessWidget {
  final int index;
  final LessonTime time;

  final GestureTapCallback onTap;

  const LessonTimeTile({Key key, this.index, this.time, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${index + 1}-я пара'),
            Text(time == null
                ? ' '
                : '${time.start.format(context)}-${time.end.format(context)}')
          ],
        ),
        onTap: () async {
          onTap();
        },
      ),
    );
  }
}
