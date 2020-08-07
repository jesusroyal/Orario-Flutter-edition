import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
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
              "Пожалуйста подождите",
              style: TextStyle(color: Colors.black),
            )
          ]),
        )
      ],
    );
  }
}
