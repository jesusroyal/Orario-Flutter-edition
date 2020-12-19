import 'package:flutter/material.dart';
import 'package:orario/screens/home_module/list_screen/list_screen.dart';
import 'package:orario/screens/widgets/token_dialog.dart';

class LessonEditSettingsTile extends StatelessWidget {
  const LessonEditSettingsTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Text('Редактирование расписания'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return TokenDialog(
                    onValid: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListScreen(isEditor: true),
                          ));
                    },
                  );
                },
              );
            }));
  }
}
