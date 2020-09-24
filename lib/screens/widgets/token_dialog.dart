import 'package:flutter/material.dart';
import 'package:orario/screens/ui_constants.dart';
import 'package:orario/services/orario_service.dart';

import 'loading_widget.dart';

class TokenDialog extends StatelessWidget {
  String _token = '';

  final VoidCallback onValid;

  TokenDialog({Key key, this.onValid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(children: [
      Text(
        'Введите Ваш Токен',
        textAlign: TextAlign.center,
        style: OrarioText.h5,
      ),
      TextField(
        onChanged: (value) {
          _token = value;
        },
      ),
      RaisedButton(
        child: Text('Войти'),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => LoadingDialog(),
          );
          OrarioService.verify(token: _token).then((valid) {
            if (valid) {
              onValid();
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    children: [Text('Неправильный токен')],
                  );
                },
              );
            }
          });
        },
      )
    ]);
  }
}
