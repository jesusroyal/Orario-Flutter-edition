import 'package:flutter/material.dart';
import 'package:orario/screens/home_module/list_screen/list_screen.dart';
import 'package:orario/screens/home_module/settings_screen/subgroup_switch.dart';
import 'package:orario/screens/home_module/settings_screen/timetable_screen.dart';
import 'package:orario/screens/widgets/loading_widget.dart';
import 'package:orario/screens/widgets/token_dialog.dart';
import 'package:orario/services/orario_service.dart';
import 'package:orario/services/orario_settings.dart';

class SettingsScreen extends StatelessWidget {
  final List<String> _settingsTitles = [
    'Сброс настроек',
    'Редактирование расписания',
    'Редактирование времени'
  ];

  Widget aboutTile() {
    return Card(
      child: Container(
        margin: EdgeInsets.all(8.0),
        height: 70.0,
        child: Row(
          children: [
            Image(image: AssetImage('assets/orariologo.png')),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Orario v0.0.4',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
                Text('Твой учебный ассистент!'),
                Text('telegram: @shevelinsky'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            if (index == 0) {
              return SubgroupTile();
            } else {
              return Card(
                child: ListTile(
                  title: Text(_settingsTitles[index - 1]),
                  onTap: () {
                    switch (index) {
                      case 1:
                        OrarioService.resetSettings().then((value) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/welcome', (route) => false);
                        });

                        break;
                      case 2:
                        showDialog(
                          context: context,
                          builder: (context) {
                            return TokenDialog(
                              onValid: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ListScreen(isEditor: true),
                                    ));
                              },
                            );
                          },
                        );

                        break;
                      case 3:
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

                        break;
                      default:
                    }
                  },
                ),
              );
            }
          }),
    );
  }
}
