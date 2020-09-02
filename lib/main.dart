import 'package:flutter/material.dart';
import 'package:orario/screens/ui_constants.dart';
import 'package:orario/screens/welcome_module/welcome_screen.dart';
import 'package:orario/screens/home_module/home_screen.dart';
import 'package:orario/services/orario_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

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
      theme: ThemeData(
          appBarTheme: AppBarTheme(color: OrarioColors.darkAccent),
          backgroundColor: OrarioColors.backGround,
          scaffoldBackgroundColor: OrarioColors.backGround,
          accentColor: OrarioColors.darkAccent),
      debugShowCheckedModeBanner: false,
      initialRoute: needsLogin ? '/welcome' : '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/welcome': (context) => WelcomeScreen()
      },
    );
  }
}
