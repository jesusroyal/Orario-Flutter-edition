import 'package:flutter/material.dart';
import 'package:orario/services/lesson_model.dart';
import 'package:orario/services/orario_service.dart';

class EditScreen extends StatelessWidget {
  final String path;
  final Lesson lesson;

  String _name = '';
  String _location = '';
  String _don = '';
  LessonType _type;

  EditScreen({Key key, this.path}) : lesson = OrarioService.lessonDict[path];

  void _tapSaved() {
    print('Нажал сохранить$_name,$_location');
    OrarioService.lessonDict[path].name = _name;
    //Доделать каждый пункт
  }

  void _initBuffer() {
    _name = lesson.name;
    _location = lesson.location;
    _don = lesson.don;
    _type = lesson.type;
  }

//Добавить выбор типа
  @override
  Widget build(BuildContext context) {
    _initBuffer();
    return Scaffold(
      appBar: AppBar(title: Text('Номер пары')), //Вставить номер пары
      body: Container(
        child: Column(
          children: [
            Text('Название'),
            TextFormField(
              initialValue: lesson.name,
              onChanged: (name) => _name = name,
            ),
            Text('Расположение'),
            TextFormField(
              initialValue: lesson.location,
              onChanged: (location) => _location = location,
            ),
            Text('Преподаватель'),
            TextFormField(
              initialValue: lesson.don,
              onChanged: (don) => _don = don,
            ),
            MaterialButton(
              child: Text('Сохранить'),
              onPressed: () {
                _tapSaved();
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
