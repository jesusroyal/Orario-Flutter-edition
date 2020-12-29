import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orario/domain/bloc/welcome/welcome_bloc.dart';
import 'package:orario/domain/bloc/welcome/welcome_event.dart';
import 'package:orario/domain/bloc/welcome/welcome_state.dart';
import 'package:orario/presentation/login/group_page.dart';

class UniversityPage extends StatefulWidget {
  @override
  _UniversityPageState createState() => _UniversityPageState();
}

class _UniversityPageState extends State<UniversityPage> {
  WelcomeBloc welcomeBloc;

  @override
  void initState() {
    welcomeBloc = WelcomeBloc();
    welcomeBloc.add(WelcomePressed());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Список ВУЗов'),
        ),
        body: BlocProvider(
          create: (_) => welcomeBloc,
          child:
              BlocBuilder<WelcomeBloc, WelcomeState>(builder: (context, state) {
            if (state is WelcomeLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UniversityLoaded) {
              return ListView.builder(
                itemCount: state.universities.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(state.universities[index]),
                      onTap: () {
                        welcomeBloc.add(UniversityPressed(index: index));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GroupPage(
                              welcomeBloc: welcomeBloc,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
            return Text('Something went wrong');
          }),
        ));
  }
}
