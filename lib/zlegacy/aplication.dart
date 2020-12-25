import 'package:flutter/material.dart';
import 'package:orario/legacy/ui_constants.dart';

import 'loading_screen.dart';
import '../screens/base_screens.dart';

import '../init_stream/init_bloc.dart';

class OrarioApp extends StatelessWidget {
  final bloc = AppStream();

  static final colors = OrarioColors();
  static final theme = OrarioTheme();
  static final fonts = OrariFontStyles();

  @override
  Widget build(BuildContext context) {
    bloc.init();
    return MaterialApp(
      theme: OrarioApp.theme.light,
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => HomeScreen(),
        '/welcome': (context) => WelcomeScreen()
      },
      home: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case AppState.loading:
                return LoadingScreen();
                break;
              case AppState.home:
                return HomeScreen();
                break;
              case AppState.login:
                return WelcomeScreen();
                break;
              default:
                return Scaffold(
                  body: Text('Default'),
                );
            }
          }),
    );
  }
}
