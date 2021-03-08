import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orario/domain/bloc/admin/lesson_time_edit_bloc/lesson_time_edit_bloc.dart';
import 'package:orario/domain/bloc/admin/lesson_time_edit_bloc/lesson_time_edit_event.dart';
import 'package:orario/domain/bloc/admin/lesson_time_edit_bloc/lesson_time_edit_state.dart';
import 'package:orario/domain/model/model_export.dart';

import 'lesson_time_edit_dialog.dart';
import 'lesson_time_widget.dart';

class LessonTimePage extends StatefulWidget {
  @override
  _LessonTimePageState createState() => _LessonTimePageState();
}

class _LessonTimePageState extends State<LessonTimePage> {
  LessonTimeEditBloc bloc;

  @override
  void initState() {
    bloc = LessonTimeEditBloc();
    bloc.add(LessonTimeOpened());
    super.initState();
  }

  List<LessonTime> list = [];

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
                  bloc.add(LessonTimePressSave(list));
                })
          ],
        ),
        body: BlocListener<LessonTimeEditBloc, LessonTimeEditState>(
            listener: (context, state) {
              if (state is LessonTimeEditLoading) {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              if (state is LessonTimeEditLoaded) {
                setState(() {
                  list = state.list;
                });
              }
              if (state is LessonTimeEditSaving) {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              if (state is LessonTimeEditSaved) {
                Navigator.pop(context);
              }
            },
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return LessonTimeTile(
                    index: index,
                    time: list[index],
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return LessonTimeEditDialog(
                            time: list[index],
                            index: index,
                            onSave: (time) {
                              setState(() {
                                list[index] = time;
                              });
                            },
                          );
                        },
                      );
                    },
                  );
                })),
      ),
    );
  }
}
