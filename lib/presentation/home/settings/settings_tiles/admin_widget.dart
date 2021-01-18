import 'package:flutter/material.dart';

class AdminTile extends StatelessWidget {
  String _value = "";

  final void Function({String token}) onSubmit;

  AdminTile({Key key, @required this.onSubmit}) : super(key: key);

  AlertDialog dialog(BuildContext context) {
    return AlertDialog(
      title: Text('Vvedite token'),
      content: TextField(
        onChanged: (value) {
          _value = value;
        },
      ),
      actions: [
        FlatButton(
            onPressed: () {
              onSubmit(token: _value);
            },
            child: Text('Ok')),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Otmena'))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Text('Zajti v admin dwij'),
            onTap: () {
              showDialog(
                  context: context, builder: (context) => dialog(context));
            }));
  }
}
