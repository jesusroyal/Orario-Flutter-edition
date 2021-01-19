import 'package:flutter/material.dart';
import 'package:orario/domain/model/model_export.dart';

class LessonTimeEditDialog extends StatefulWidget {
  final LessonTime time;

  const LessonTimeEditDialog({Key key, this.time, this.index, this.onSave})
      : super(key: key);

  @override
  _LessonTimeEditDialogState createState() =>
      _LessonTimeEditDialogState(time.start, time.end);
  final int index;

  final Function(LessonTime) onSave;
}

class _LessonTimeEditDialogState extends State<LessonTimeEditDialog> {
  TimeOfDay start;
  TimeOfDay end;

  _LessonTimeEditDialogState(this.start, this.end);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${widget.index + 1}-я пара'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlatButton(
              onPressed: () async {
                var selectedTime = await showTimePicker(
                  helpText: 'Начало пары',
                  initialTime: TimeOfDay.now(),
                  context: context,
                );
                setState(() {
                  start = selectedTime;
                });
              },
              child: Text(start.format(context))),
          FlatButton(
              onPressed: () async {
                var selectedTime = await showTimePicker(
                  helpText: 'Начало пары',
                  initialTime: TimeOfDay.now(),
                  context: context,
                );
                setState(() {
                  end = selectedTime;
                });
              },
              child: Text(end.format(context)))
        ],
      ),
      actions: [
        FlatButton(
            onPressed: () {
              widget.onSave(LessonTime(
                  start: start,
                  end: end,
                  breakDuration:
                      0)); //TODO: Deal with not needed break duration
              Navigator.pop(context);
            },
            child: Text('Сохранить')),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Отмена'))
      ],
    );
  }
}
