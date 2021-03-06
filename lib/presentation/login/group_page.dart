import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orario/domain/bloc/welcome/welcome_bloc.dart';
import 'package:orario/domain/bloc/welcome/welcome_event.dart';
import 'package:orario/domain/bloc/welcome/welcome_state.dart';
import 'package:orario/presentation/home/home_page.dart';
import './widgets/subgroup_dialog.dart';

class GroupPage extends StatefulWidget {
  final WelcomeBloc welcomeBloc;
  const GroupPage({@required this.welcomeBloc});

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  void chooseSubgroup(int index) {
    widget.welcomeBloc.add(SubGroupPressed(index));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => widget.welcomeBloc,
      child: BlocListener<WelcomeBloc, WelcomeState>(
        listener: (context, state) {
          if (state is WelcomeComplete) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
              ModalRoute.withName('/'),
            );
          }
          if (state is SubGroupDialog) {
            showDialog(
                context: context,
                builder: (context) {
                  return SubgroupDialog(onSelect: (index) => chooseSubgroup(0));
                });
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Список групп'),
          ),
          body: BlocBuilder<WelcomeBloc, WelcomeState>(
            builder: (context, state) {
              if (state is GroupsLoading) {
                return const Center(
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
                        onTap: () {
                          widget.welcomeBloc.add(GroupPressed(index: index));
                        },
                      ),
                    );
                  },
                );
              }
              return const Text('Something went wrong');
            },
          ),
        ),
      ),
    );
  }
}
