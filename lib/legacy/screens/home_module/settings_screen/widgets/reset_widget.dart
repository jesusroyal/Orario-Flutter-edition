import 'package:flutter/material.dart';
import 'package:orario/services/orario_service.dart';

class ResetSettingsTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Text('Сброс настроек'),
            onTap: () {
              OrarioService.resetSettings().then((value) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/welcome', (route) => false);
              });
            }));
  }
}
