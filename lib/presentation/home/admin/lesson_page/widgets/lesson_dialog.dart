import 'package:flutter/material.dart';
import 'package:orario/domain/model/model_export.dart';
import 'package:orario/presentation/home/admin/lesson_page/widgets/lesson_type_selector.dart';

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
      content: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: 'Name'),
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Location'),
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Don'),
          ),
          LessonTypeSelector(
            currentType: 0,
            onTap: (index) {},
          )
        ],
      ),
      actions: [
        FlatButton(
            onPressed: () {
              widget.onSave(Lesson(
                  name: 'Some name',
                  location: 'some location',
                  don: 'some don',
                  type: LessonType.lecture));
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
