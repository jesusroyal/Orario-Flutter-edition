import 'package:flutter/material.dart';
import 'package:orario/domain/bloc/setup/setup_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orario/domain/bloc/setup/setup_event.dart';
import 'package:orario/domain/bloc/setup/setup_state.dart';
import 'package:orario/presentation/home/home_page.dart';
import 'package:orario/presentation/splash_page.dart';
import 'package:orario/presentation/welcome/welcome_page.dart';

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  SetupBloc setupBloc;

  @override
  void initState() {
    setupBloc = SetupBloc();
    setupBloc.add(AppLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => setupBloc,
        child: BlocListener<SetupBloc, SetupState>(
          listener: (context, state) {
            if (state is SetupNotCompleted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => WelcomePage(),
                ),
              );
            } else if (state is SetupCompleted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => HomePage(),
                ),
              );
            }
          },
          child: SplashPage(),
        ),
      ),
    );
  }
}
