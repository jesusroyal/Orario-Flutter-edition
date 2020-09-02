import 'package:flutter/material.dart';
import 'package:orario/screens/ui_constants.dart';
import 'package:orario/services/lesson_model.dart';
import 'package:orario/services/orario_service.dart';

class EditScreen extends StatelessWidget {
  final String path;
  final Lesson lesson;

  String _name = '';
  String _location = '';
  String _don = '';
  int _type = 0;

  EditScreen({Key key, this.path}) : lesson = OrarioService.lessonDict[path];

  void _tapSaved() {
    OrarioService.lessonDict[path] =
        Lesson(name: _name, location: _location, don: _don, type: _type);
  }

  void _initBuffer() {
    if (lesson != null) {
      _name = lesson.name;
      _location = lesson.location;
      _don = lesson.don;
      _type = lesson.type.index;
    }
  }

//Добавить выбор типа
  @override
  Widget build(BuildContext context) {
    _initBuffer();
    return Scaffold(
      appBar: AppBar(
        title: Text('Пара №${int.parse(path.split('/')[2]) + 1}'),
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                OrarioService.lessonDict[path] = null;
                Navigator.pop(context);
              }),
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _tapSaved();
                Navigator.pop(context);
              })
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Text('Название'),
            TextFormField(
              initialValue: _name,
              onChanged: (name) => _name = name,
            ),
            Text('Расположение'),
            TextFormField(
              initialValue: _location,
              onChanged: (location) => _location = location,
            ),
            Text('Преподаватель'),
            TextFormField(
              initialValue: _don,
              onChanged: (don) => _don = don,
            ),
            LessonTypeSelector(
              currentType: _type,
              onTap: (value) {
                print(value);
                _type = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LessonTypeSelector extends StatefulWidget {
  final ValueChanged<int> onTap;
  final int currentType;
  const LessonTypeSelector({Key key, this.onTap, this.currentType})
      : super(key: key);

  @override
  _LessonTypeSelectorState createState() =>
      _LessonTypeSelectorState(currentType: currentType);
}

class _LessonTypeSelectorState extends State<LessonTypeSelector> {
  int currentType = 0;

  _LessonTypeSelectorState({this.currentType});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LessonTypeButton(
          type: LessonType.lecture,
          isPressed: currentType == 0,
          onTap: () {
            setState(() {
              currentType = 0;
              widget.onTap(currentType);
            });
          },
        ),
        LessonTypeButton(
          type: LessonType.lab,
          isPressed: currentType == 1,
          onTap: () {
            setState(() {
              currentType = 1;
              widget.onTap(currentType);
            });
          },
        ),
        LessonTypeButton(
          type: LessonType.seminar,
          isPressed: currentType == 2,
          onTap: () {
            setState(() {
              currentType = 2;
              widget.onTap(currentType);
            });
          },
        ),
      ],
    );
  }
}

class LessonTypeButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isPressed;
  final LessonType type;

  String get _title {
    switch (type) {
      case LessonType.lab:
        return 'Лаба';
      case LessonType.lecture:
        return 'Лекция';
      case LessonType.seminar:
        return 'Семинар';
    }
    return '';
  }

  IconData get _icon {
    switch (type) {
      case LessonType.lab:
        return Icons.computer;
      case LessonType.lecture:
        return Icons.book;
      case LessonType.seminar:
        return Icons.brush;
    }
    return null;
  }

  LessonTypeButton({Key key, this.onTap, this.isPressed, @required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: isPressed ? OrarioColors.darkAccent : OrarioColors.lighAccent,
      child: Row(
        children: [
          Icon(_icon),
          SizedBox(
            width: 10.0,
          ),
          Text(_title),
        ],
      ),
      onPressed: () => onTap(),
    );
  }
}
