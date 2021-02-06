import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:orario/domain/bloc/admin/lesson_edit_bloc/lesson_edit_bloc.dart';
import 'package:orario/domain/bloc/admin/lesson_edit_bloc/lesson_edit_event.dart';
import 'package:orario/domain/bloc/admin/lesson_edit_bloc/lesson_edit_state.dart';
import 'package:orario/domain/model/model_export.dart';
import 'package:orario/presentation/home/admin/lesson_page/widgets/lesson_dialog.dart';
import 'package:orario/presentation/home/admin/lesson_page/widgets/lesson_row.dart';
import 'package:orario/presentation/home/list/list_divider.dart';

class LessonPage extends StatefulWidget {
  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  LessonEditBloc bloc;

  @override
  void initState() {
    bloc = LessonEditBloc();
    bloc.add(LessonEditOpened());
    super.initState();
  }

  Map<int, Map<int, Map<int, LessonPair>>> lessons = {0: {}};

  final snackBar = const SnackBar(content: Text('Загружаю'));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => bloc,
        child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () {
                      bloc.add(LessonEditSave(lessons: lessons));
                    })
              ],
            ),
            body: BlocListener<LessonEditBloc, LessonEditState>(
                listener: (context, state) {
                  print(state);
                  if (state is LessonEditLoading) {
                    Scaffold.of(context).showSnackBar(snackBar);
                  }
                  if (state is LessonEditLoaded) {
                    print(state.lessons[0].length);
                    setState(() {
                      lessons = state.lessons;
                    });
                  }
                },
                child: GroupListView(
                  countOfItemInSection: (count) =>
                      lessons[0][count].keys.length,
                  sectionsCount: lessons[0].keys.length,
                  itemBuilder: (context, index) {
                    print(lessons);
                    return LessonRow(
                      lessons: {
                        0: lessons[0][index.section][index.index],
                        1: lessons[0][index.section][index.index]
                      },
                      onTap: (index2) {
                        showDialog(
                          context: context,
                          builder: (context) => LessonEditDialog(
                            lessonPair: lessons[index.section][index.index]
                                [index2],
                            onSave: (lesson) {
                              setState(() {
                                lessons[0][index.section][index.index] =
                                    LessonPair(
                                        lesson: lesson,
                                        time: lessons[index.section]
                                                [index.index][0]
                                            .time);
                              });
                            },
                          ),
                        );
                      },
                    );
                  },
                  groupHeaderBuilder: (context, section) {
                    return ListSection(section);
                  },
                ))));
  }
}
