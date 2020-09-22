import 'package:flutter/material.dart';
import 'package:orario/screens/ui_constants.dart';

class LoadingDialog extends StatelessWidget {
  final String message = 'Пожалуйста подождите';

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5.0),
          child: Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 30,
              ),
              Text(
                message,
                style: OrarioText.h5,
              )
            ]),
          ),
        )
      ],
    );
  }
}
