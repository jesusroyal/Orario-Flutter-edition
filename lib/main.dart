import 'package:flutter/material.dart';
import 'package:orario/screens/login/welcome_screen.dart';
import 'package:orario/screens/home/home_screen.dart';
import 'package:orario/services/setup_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SetupService.init(
    ready: (needsLogin) {
      runApp(Orario(needsLogin));
    },
  );
}

class Orario extends StatelessWidget {
  final bool needsLogin;

  Orario(this.needsLogin);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      initialRoute: needsLogin ? '/' : '/welcome',
      routes: {
        '/': (context) => HomeScreen(),
        '/welcome': (context) => WelcomeScreen()
      },
    );
  }
}
