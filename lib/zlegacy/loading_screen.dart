import 'package:flutter/material.dart';
import 'package:orario/screens/ui_constants.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text(
              'Загрузка',
              style: OrarioText.h1,
            )
          ],
        ),
      ),
    );
  }
}
