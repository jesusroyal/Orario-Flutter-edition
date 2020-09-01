import 'package:flutter/material.dart';
import 'package:orario/screens/home_module/list_screen/list_screen.dart';
import 'package:orario/screens/ui_constants.dart';
import 'package:orario/screens/widgets/loading_widget.dart';
import 'package:orario/services/orario_service.dart';

class SettingsScreen extends StatelessWidget {
  final List<String> _settingsTitles = [
    'Сброс настроек',
    'Редактирование расписания'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(_settingsTitles[index]),
                onTap: () {
                  switch (index) {
                    case 0:
                      OrarioService.resetSettings().then((value) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/welcome', (route) => false);
                      });

                      break;
                    case 1:
                      showDialog(
                        context: context,
                        builder: (context) {
                          String _token;
                          return SimpleDialog(
                            children: [
                              Text('Введите токен'),
                              TextField(
                                onChanged: (value) => _token = value,
                              ),
                              RaisedButton(
                                child: Text('Войти'),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => LoadingDialog(),
                                  );
                                  OrarioService.verify(token: _token)
                                      .then((valid) {
                                    if (valid) {
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ListScreen(isEditor: true),
                                          ));
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return SimpleDialog(
                                            children: [
                                              Text('Неправильный токен')
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  });
                                },
                              )
                            ],
                          );
                        },
                      );

                      break;
                    default:
                  }
                },
              ),
            );
          }),
    );
  }
}
