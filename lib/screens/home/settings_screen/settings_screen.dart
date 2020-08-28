import 'package:flutter/material.dart';
import 'package:orario/screens/home/settings_screen/settings_sevice.dart';
import 'package:orario/ui.dart';

class SettingsScreen extends StatelessWidget {
  final List<String> _settingsTitles = [
    'Сброс настроек',
    'Редактирование расписания'
  ];

  void _resetSettings(BuildContext context) {
    SettingsService.resetSettings();
    Navigator.of(context).pushNamedAndRemoveUntil('/welcome', (route) => false);
  }

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
                    _resetSettings(context);
                    break;
                  default:
                }
              },
            );
          }),
    );
  }
}
