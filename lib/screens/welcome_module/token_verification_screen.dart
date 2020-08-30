import 'package:flutter/material.dart';
import 'package:orario/screens/home_module/list_screen/list_screen.dart';
import 'package:orario/services/orario_service.dart';

class TokenVerification extends StatelessWidget {
  final Map<String, String> tokenMap;

  String _token = '';
  String _title = '';

  TokenVerification({Key key, this.tokenMap}) : super(key: key);

  void _addGroup({BuildContext context}) {
    String group = tokenMap.keys
        .firstWhere((k) => tokenMap[k] == _token, orElse: () => null);
    if (group != null) {
      OrarioService.setupGroup(group: group, title: _title).then((value) {
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListScreen(isEditor: true),
            ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Создание группы'),
      ),
      body: Container(
        child: Column(
          children: [
            Text('Введите ваше токен'),
            TextField(
              onChanged: (value) {
                _token = value;
              },
            ),
            Text('Введите название вашей группы'),
            TextField(
              onChanged: (value) {
                _title = value;
              },
            ),
            MaterialButton(
              child: Text('Добавить группу'),
              onPressed: () => _addGroup(context: context),
            )
          ],
        ),
      ),
    );
  }
}
