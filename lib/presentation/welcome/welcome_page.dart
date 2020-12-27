import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Добро пожаловать блаблабла'),
            Image(image: AssetImage('assets/logo.png')),
            Text('Ваш персональный ассистент'),
            RaisedButton(
              child: Text('Button'),
            )
          ],
        ),
      ),
    );
  }
}
