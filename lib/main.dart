import 'package:flutter/material.dart';
import 'package:orario/ui.dart';

void main() {
  runApp(Orario());
}

class Orario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Orario',
        home: Scaffold(
          backgroundColor: OrarioColors.backGround,
          body: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Добро пожаловать в Orario!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Ваше персональный ассистент',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
                  ),
                  Image(image: AssetImage('assets/orariologo.png'))
                ],
              )),
        ));
  }
}
