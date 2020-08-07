import 'package:flutter/material.dart';
import 'package:orario/screens/login/welcome_screen.dart';
import 'package:orario/screens/home/home_screen.dart';
import 'package:orario/services/setup_service.dart';

void main() {
  // SetupService().getData();
  runApp(Orario());
}

class Orario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      initialRoute: '/welcome',
      routes: {
        '/': (context) => HomeScreen(),
        '/welcome': (context) => WelcomeScreen()
      },
    );
  }
}
