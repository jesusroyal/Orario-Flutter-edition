import 'package:flutter/material.dart';
import 'package:orario/domain/model/model_export.dart';

class LessonEditDialog extends StatefulWidget {
  final LessonPair lessonPair;
  final Function(Lesson) onSave;

  const LessonEditDialog({Key key, this.lessonPair, this.onSave})
      : super(key: key);
  @override
  _LessonEditDialogState createState() => _LessonEditDialogState();
}

class _LessonEditDialogState extends State<LessonEditDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('some title'),
      actions: [
        FlatButton(
            onPressed: () {
              //widget.onSave();
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
