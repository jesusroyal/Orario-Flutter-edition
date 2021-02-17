import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orario/domain/bloc/home/home_list/home_list_domain.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:orario/internal/theme.dart';
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
      child: BlocBuilder<HomeListBloc, HomeListState>(
        builder: (context, state) {
          if (state is HomeListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is HomeListLoaded) {
            return Scaffold(
              body: GroupListView(
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
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton.extended(
                  backgroundColor: OrarioUI.colors.green,
                  onPressed: () {
                    homeListBloc.add(HomeListDidChooseWeek(
                        isSecondWeek: !state.isSecondWeek));
                  },
                  label: state.isSecondWeek
                      ? const Text('Неделя II')
                      : const Text('Неделя I')),
            );
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}
