import 'package:flutter/material.dart';
import 'package:orario/screens/welcome_module/welcome_screen.dart';
import 'package:orario/screens/home_module/home_screen.dart';
import 'package:orario/services/orario_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  OrarioService.setupApp().then((needsLogin) => runApp(Orario(
        needsLogin: needsLogin,
      )));
}

class Orario extends StatelessWidget {
  final bool needsLogin;

  Orario({this.needsLogin});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: needsLogin ? '/welcome' : '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/welcome': (context) => WelcomeScreen()
      },
    );
  }
}
