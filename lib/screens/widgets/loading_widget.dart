import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  final String message = 'Пожалуйста подождите';

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: <Widget>[
        Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            CircularProgressIndicator(),
            SizedBox(
              width: 30,
            ),
            Text(
              message,
              style: TextStyle(color: Colors.black),
            )
          ]),
        )
      ],
    );
  }
}
