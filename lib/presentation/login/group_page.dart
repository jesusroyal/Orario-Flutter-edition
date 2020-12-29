import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orario/domain/bloc/welcome/welcome_bloc.dart';
import 'package:orario/domain/bloc/welcome/welcome_state.dart';

class GroupPage extends StatefulWidget {
  WelcomeBloc welcomeBloc;
  GroupPage({@required this.welcomeBloc});

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список групп'),
      ),
      body: BlocProvider(
        create: (_) => widget.welcomeBloc,
        child: BlocBuilder<WelcomeBloc, WelcomeState>(
          builder: (context, state) {
            if (state is GroupsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GroupsLoaded) {
              return ListView.builder(
                itemCount: state.groups.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(state.groups[index]),
                      onTap: () {},
                    ),
                  );
                },
              );
            }
            return Text('Something went wrong');
          },
        ),
      ),
    );
  }
}
