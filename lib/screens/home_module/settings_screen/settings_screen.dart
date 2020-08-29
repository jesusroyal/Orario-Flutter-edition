import 'package:flutter/material.dart';
import 'package:orario/screens/home_module/list_screen/list_screen.dart';
import 'package:orario/screens/ui_constants.dart';
import 'package:orario/services/orario_service.dart';

class SettingsScreen extends StatelessWidget {
  final List<String> _settingsTitles = [
    'Сброс настроек',
    'Редактирование расписания'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: OrarioColors.backGround,
      child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_settingsTitles[index]),
              onTap: () {
                switch (index) {
                  case 0:
                    OrarioService.resetSettings();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/welcome', (route) => false);
                    break;
                  case 1:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListScreen(isEditor: true),
                        ));
                    break;
                  default:
                }
              },
            );
          }),
    );
  }
}
