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
  String _name;
  String _location;
  String _don;
  LessonType _type;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.lessonPair.time.start.format(context)),
      content: Column(
        children: [
          TextField(
            onChanged: (value) => _name = value,
            decoration:
                const InputDecoration(hintText: 'Практические основы практики'),
          ),
          TextField(
              onChanged: (value) => _location = value,
              decoration: const InputDecoration(hintText: '212-3')),
          TextField(
            onChanged: (value) => _don = value,
            decoration: const InputDecoration(hintText: 'Веренич М. С.'),
          ),
          LessonTypeSelector(
            currentType: LessonType.lab,
            onChanged: (type) => _type = type,
          )
        ],
      ),
      actions: [
        FlatButton(
            onPressed: () {
              widget.onSave(Lesson(
                  name: _name, location: _location, don: _don, type: _type));
              Navigator.pop(context);
            },
            child: const Text('Сохранить')),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Отмена'))
      ],
    );
  }
}
