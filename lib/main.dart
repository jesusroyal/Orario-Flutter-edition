import 'package:flutter/material.dart';
import 'package:orario/screens/ui_constants.dart';
import 'package:orario/screens/welcome_module/welcome_screen.dart';
import 'package:orario/screens/home_module/home_screen.dart';
import 'package:orario/services/orario_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool needsLogin = await OrarioService.setupApp();
  runApp(Orario(
    needsLogin: needsLogin,
  ));
}

class Orario extends StatelessWidget {
  final bool needsLogin;

  Orario({this.needsLogin});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: OrarioUI.theme,
      debugShowCheckedModeBanner: false,
      initialRoute: needsLogin ? '/welcome' : '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/welcome': (context) => WelcomeScreen()
      },
    );
  }
}
