import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:orario/domain/bloc/admin/lesson_edit_bloc/lesson_edit_bloc.dart';
import 'package:orario/domain/bloc/admin/lesson_edit_bloc/lesson_edit_event.dart';
import 'package:orario/domain/bloc/admin/lesson_edit_bloc/lesson_edit_state.dart';
import 'package:orario/domain/model/model_export.dart';
import 'package:orario/internal/theme.dart';
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

  int week = 0;

  final snackBar = const SnackBar(content: Text('Загружаю'));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => bloc,
        child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton.extended(
                backgroundColor: OrarioUI.colors.green,
                onPressed: () {
                  bloc.add(LessonEditChangedWeek(week = 1 - week));
                },
                label: week != 0
                    ? const Text('Неделя II')
                    : const Text('Неделя I')),
            appBar: AppBar(
              title: const Text('Редактор'),
              actions: [
                IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Вы уверены?'),
                              content: const Text(
                                  'Вы хотети скопировать первую неделю на вторую?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      bloc.add(
                                          LessonEditCopyWeek(lessons: lessons));
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Да')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Нет'))
                              ],
                            );
                          });
                    }),
                IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: () {
                      bloc.add(LessonEditSave(lessons: lessons, week: week));
                    }),
              ],
            ),
            body: BlocListener<LessonEditBloc, LessonEditState>(
                listener: (context, state) {
                  if (state is LessonEditLoading) {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  if (state is LessonEditLoaded) {
                    setState(() {
                      lessons = state.lessons;
                      week = state.week;
                    });
                  }
                },
                child: GroupListView(
                  countOfItemInSection: (count) =>
                      lessons[0][count].keys.length,
                  sectionsCount: lessons[0].keys.length,
                  itemBuilder: (context, index) {
                    return LessonRow(
                      lessons: {
                        0: lessons[0][index.section][index.index],
                        1: lessons[1][index.section][index.index]
                      },
                      onExpand: () {
                        setState(() {
                          lessons[1][index.section][index.index] =
                              lessons[0][index.section][index.index];
                        });
                      },
                      onTap: (index2) {
                        showDialog(
                          context: context,
                          builder: (context) => LessonEditDialog(
                            lessonPair: lessons[index2][index.section]
                                [index.section],
                            onSave: (lesson) {
                              setState(() {
                                lessons[index2][index.section][index.index] =
                                    LessonPair(
                                        lesson: lesson,
                                        time: lessons[index2][index.section]
                                                [index.index]
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
