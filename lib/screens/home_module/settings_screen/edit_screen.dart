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
    OrarioService.lessonDict[path] =
        Lesson(name: _name, location: _location, don: _don, type: 1);
    //Доделать каждый пункт
  }

  void _initBuffer() {
    if (lesson != null) {
      _name = lesson.name;
      _location = lesson.location;
      _don = lesson.don;
      _type = lesson.type;
    }
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
