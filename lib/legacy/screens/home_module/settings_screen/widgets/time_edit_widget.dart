import 'package:flutter/material.dart';
import 'package:orario/screens/widgets/token_dialog.dart';

import '../timetable_screen.dart';

class TimeEditSettingsTile extends StatelessWidget {
  const TimeEditSettingsTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Text('Редактирование расписания звонков'),
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
                            builder: (context) => TimeTableEditor(),
                          ));
                    },
                  );
                },
              );
            }));
  }
}
