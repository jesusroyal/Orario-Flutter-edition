import 'package:flutter/material.dart';

class AdminTile extends StatelessWidget {
  String _value = "";

  AlertDialog dialog(BuildContext context) {
    return AlertDialog(
      title: Text('Vvedite token'),
      content: TextField(
        onChanged: (value) {
          _value = value;
        },
      ),
      actions: [
        FlatButton(onPressed: () {}, child: Text('Ok')),
        FlatButton(onPressed: () {}, child: Text('Otmena'))
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
