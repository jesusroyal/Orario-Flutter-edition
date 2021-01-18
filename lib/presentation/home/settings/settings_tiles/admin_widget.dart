import 'package:flutter/material.dart';

class AdminTile extends StatelessWidget {
  String _value = "";

  final void Function(String token) onSubmit;

  AdminTile({Key key, @required this.onSubmit}) : super(key: key);

  AlertDialog dialog(BuildContext context) {
    return AlertDialog(
      title: Text('Введите ваш токен'),
      content: TextField(
        obscureText: true,
        autofocus: true,
        onChanged: (value) {
          _value = value;
        },
      ),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
              onSubmit(_value);
            },
            child: Text('Ок')),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Отмена'))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Text('Войти в панель администрирования'),
            onTap: () {
              showDialog(
                  context: context, builder: (context) => dialog(context));
            }));
  }
}
