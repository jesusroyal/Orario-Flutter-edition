import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orario/domain/bloc/home/home_list/home_list_bloc.dart';
import 'package:orario/domain/bloc/home/home_list/home_list_state.dart';
import 'package:orario/domain/bloc/home/home_list/home_list_event.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:orario/presentation/home/list/list_divider.dart';
import 'package:orario/presentation/home/list/list_tile.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  HomeListBloc homeListBloc;

  @override
  void initState() {
    homeListBloc = HomeListBloc();
    homeListBloc.add(HomeListOpened());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => homeListBloc,
      child: Scaffold(
        body: BlocBuilder<HomeListBloc, HomeListState>(
          builder: (context, state) {
            if (state is HomeListLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeListLoaded) {
              return GroupListView(
                countOfItemInSection: (count) => state.lessons[count].length,
                sectionsCount: state.lessons.entries.length,
                itemBuilder: (context, index) {
                  return ListWidget(
                    lessonPair: state.lessons[index.section][index.index],
                  );
                },
                groupHeaderBuilder: (context, section) {
                  return ListSection(section);
                },
              );
            }
            return Center(child: Text('Something went wrong'));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: null, label: Text('Неделя II')),
      ),
    );
  }
}
